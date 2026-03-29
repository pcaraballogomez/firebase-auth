import Foundation

extension Bundle {

    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }

    static func value(for configKey: Constants.ConfigKey) -> String? {
        Bundle.main.object(forInfoDictionaryKey: configKey.rawValue) as? String
    }
}
