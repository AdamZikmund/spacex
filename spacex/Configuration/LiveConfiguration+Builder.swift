import Foundation

extension Configuration {
    static func build() -> Configuration {
        return LiveConfiguration()
    }
}
