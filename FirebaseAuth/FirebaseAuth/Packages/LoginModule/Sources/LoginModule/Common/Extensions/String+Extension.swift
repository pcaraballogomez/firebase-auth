import Foundation

extension String {
    /// Returns a language localized version of the given string.
    /// - returns: The language localized string.
    var localized: Self {
        let auxString = (self as NSString).replacingOccurrences(of: "\0", with: "")
        return NSLocalizedString(auxString, tableName: nil, bundle: .module, value: "", comment: "")
    }
}
