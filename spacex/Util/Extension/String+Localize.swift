import Foundation

// Simple localization - some framework should be used (Localazy, ... etc)
extension String {
    func localized(_ arguments: CVarArg...) -> Self {
        String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }

    func localized() -> Self {
        NSLocalizedString(self, comment: "")
    }
}
