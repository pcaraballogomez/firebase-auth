import Foundation

extension Bundle {
    enum InfoPlistKey {
        static let googleClientID = "CLIENT_ID"
    }

    /// Convenient typed accessor for the Google client ID in Info.plist
    var googleClientID: String? {
        object(forInfoDictionaryKey: InfoPlistKey.googleClientID) as? String
    }

    /// Generic string accessor for any Info.plist key
    func string(forInfoPlistKey key: String) -> String? {
        object(forInfoDictionaryKey: key) as? String
    }
}
