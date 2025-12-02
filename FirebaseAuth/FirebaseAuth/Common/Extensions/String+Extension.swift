import Foundation

extension String {
    /// Returns a language localized version of the given string.
    /// - returns: The language localized string.
    var localized: Self {
        let auxString = (self as NSString).replacingOccurrences(of: "\0", with: "")
        return NSLocalizedString(auxString, tableName: nil, bundle: .main, value: "", comment: "")
    }

    var toUrl: URL? {
        URL(string: self)
    }
}

extension Optional where Wrapped == String {

    var isNilOrEmpty: Bool {
        guard let unwrappedString = self else {
            return true
        }
        return unwrappedString.isEmpty || unwrappedString == " "
    }

    var hasValue: Bool {
        !self.isNilOrEmpty
    }
}
