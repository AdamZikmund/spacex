import Foundation

public enum Language: String, Equatable, Codable {
    case en
    case cs

    public static var `default`: Self {
        .en
    }
}
