import Foundation
import RegexBuilder

// MARK: - Model
enum Language: String, CaseIterable {
    case en
    case cs
}

struct Localizable {
    let language: Language
    let strings: [String: String]

    init(
        language: Language,
        strings: [String: String]
    ) {
        self.language = language
        self.strings = Self.transform(language: language, strings: strings)
    }

    static func transform(
        language: Language,
        strings: [String: String]
    ) -> [String: String] {
        var transformed = Dictionary<String, String>(minimumCapacity: strings.capacity)
        for (key, value) in strings {
            let newKey = "\(key).\(language.rawValue)"
            transformed[newKey] = value
        }
        return transformed
    }
}

class Tree {
    var nodes: [Node]

    init(nodes: [Node] = []) {
        self.nodes = nodes
    }

    func parseValues(values: [String: String]) {
        for key in values.keys.sorted(by: >) {
            guard let value = values[key] else { continue }
            createNode(key: key, value: value, nodes: &nodes, parent: nil)
        }
    }

    private func createNode(
        key: String,
        value: String,
        nodes: inout [Node],
        parent: Node?
    ) {
        guard var components = key.nullableComponents(separatedBy: ".") else { return }
        guard let component = components.popFirst() else { return }
        if let node = findNode(name: component, nodes: nodes) {
            if components.isEmpty {
                node.value = value
            } else {
                createNode(key: components.joined(separator: "."), value: value, nodes: &node.nodes, parent: node)
            }
        } else {
            let node = Node(parent: parent, name: component, nodes: [], value: components.isEmpty ? value : nil)
            nodes.append(node)
            createNode(key: components.joined(separator: "."), value: value, nodes: &node.nodes, parent: node)
        }
    }

    private func findNode(name: String, nodes: [Node]) -> Node? {
        for node in nodes where node.name == name {
            return node
        }
        return nil
    }
    
    func generate() -> String {
        Struct(
            name: "L",
            structs: generate(nodes: nodes, level: 1),
            staticFunctions: [],
            level: 0
        )
        .toString()
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: .newlines)
        .filter{ !$0.isEmpty }
        .joined(separator: "\n")
    }

    private func generate(nodes: [Node], level: Int) -> [Struct] {
        var structs = [Struct]()
        for node in nodes where node.value == nil {
            structs.append(
                .init(
                    name: node.name,
                    structs: generate(nodes: node.nodes, level: level + 1),
                    staticFunctions: generate(parent: node, level: level),
                    level: level
                )
            )
        }
        return structs
    }

    private func generate(parent: Node?, level: Int) -> [StaticFunction] {
        guard let parent else { return [] }
        let nodes = parent.nodes.filter { $0.value != nil }
        guard !nodes.isEmpty else { return [] }
        var functions = [StaticFunction]()
        let arguments = nodes.sorted { ($0.value?.arguments ?? .zero) > ($1.value?.arguments ?? .zero) }
            .first?
            .value?
            .arguments ?? .zero
        let values = nodes.compactMap { node -> (Language, String)? in
            guard let language = Language(rawValue: node.name), let value = node.value else { return nil }
            return (language, value)
        }
        functions.append(
            .init(
                name: parent.name,
                arguments: arguments,
                values: values,
                level: level
            )
        )
        return functions
    }
}

class Node {
    let parent: Node?
    let name: String
    var nodes: [Node]
    var value: String?

    init(
        parent: Node?,
        name: String,
        nodes: [Node] = [],
        value: String? = nil
    ) {
        self.parent = parent
        self.name = name
        self.nodes = nodes
        self.value = value
    }
}

struct Struct {
    let name: String
    let structs: [Struct]
    let staticFunctions: [StaticFunction]
    let level: Int

    private var functions: String {
        staticFunctions.map { $0.toString() }.joined()
    }

    private var structures: String {
        structs.map { $0.toString() }.joined()
    }

    func toString() -> String {
        var string = ""
        if !structs.isEmpty {
            string += level.tabs
            string += "struct \(name.firstUppercased()) {\n"
            string += (level + 1).tabs
            string += "private init() {}"
            if !structures.isEmpty {
                string += "\n"
            }
            string += structures
            string += "\n\(level.tabs)}"
        }
        if !functions.isEmpty && !structs.isEmpty {
            string += "\n"
        }
        string += functions + "\n"
        return string
    }
}

struct StaticFunction {
    let name: String
    let arguments: Int
    let values: [(Language, String)]
    let level: Int

    private var parameters: String {
        guard arguments > .zero else { return "" }
        return (1...arguments)
            .map { ", arg\($0): String" }
            .joined()
    }

    private var format: String {
        guard arguments > .zero else { return "" }
        return (1...arguments)
            .map { ", arg\($0)" }
            .joined()
    }

    private var cases: String {
        var string = ""
        for (language, value) in values {
            string += "\n"
            string += (level + 1).tabs
            string += "case .\(language.rawValue):\n"
            string += (level + 2).tabs
            string += "return String(format: \"\(value)\""
            string += format
            string += ")"
        }
        return string
    }

    func toString() -> String {
        var string = ""
        string += level.tabs
        string += "static func \(name.firstLowercased())(_ language: Language"
        string += parameters
        string += ") -> String {\n"
        string += (level + 1).tabs
        string += "switch language {"
        string += cases
        string += "\n\((level + 1).tabs)}"
        string += "\n\(level.tabs)}"
        return string
    }
}

// MARK: - Extension
extension Int {
    var tabs: String {
        String(repeating: "\t", count: self)
    }
}

extension String {
    func firstLowercased() -> Self {
        prefix(1).lowercased() + dropFirst()
    }

    func firstUppercased() -> Self {
        prefix(1).uppercased() + dropFirst()
    }

    var arguments: Int {
        matches(of: Regex{"%@"}).count
    }
}

extension String {
    func nullableComponents(separatedBy: String) -> [Self]? {
        if isEmpty { return nil }
        return components(separatedBy: separatedBy)
    }
}

extension Array {
    mutating func popFirst() -> Element? {
        if isEmpty { return nil }
        return removeFirst()
    }
}

// MARK: - Function
func loadLocalizable(
    for language: Language,
    path: String = ""
    ) -> Localizable {
        let root = FileManager.default.currentDirectoryPath
        let fullPath = "\(root)\(path)/\(language.rawValue).lproj/Localizable.strings"
        let strings = NSDictionary(contentsOfFile: fullPath)
        guard let strings = strings as? [String: String] else {
            fatalError("Localizable.strings not found for \(fullPath)")
        }
        return Localizable(language: language, strings: strings)
}

func loadLocalizables(path: String = "") -> [Localizable] {
    Language.allCases.map { language in
        loadLocalizable(for: language, path: path)
    }
}

func write(string: String, path: String) {
    let root = FileManager.default.currentDirectoryPath
    let fullPath = "\(root)\(path)/L.swift"
    let data = string.data(using: .utf8)
    FileManager.default.createFile(atPath: fullPath, contents: data)
}

let readPath = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : ""
let writePath = CommandLine.arguments.count > 2 ? CommandLine.arguments[2] : ""
let tree = Tree()
let localizables = loadLocalizables(path: readPath)
for localizable in localizables {
    tree.parseValues(values: localizable.strings)
}
write(string: tree.generate(), path: writePath)
