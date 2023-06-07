import Foundation

// Applies rule mentioned in [https://codifiedsecurity.com/mobile-app-security-testing-checklist-ios/]
func releasePrint(_ object: Any) {
    Swift.print(object)
}

// Applies rule mentioned in [https://codifiedsecurity.com/mobile-app-security-testing-checklist-ios/]
func print(_ object: Any) {
#if DEBUG
    Swift.print(object)
#endif
}
