import Foundation

extension Bundle {

    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }

    static func getBaseUrl(withKey: Bool = true) -> String {
        guard withKey else { return baseUrl }
        return baseUrl + "/" + apiKey
    }

    static func value(for configKey: Constants.ConfigKey) -> String? {
        Bundle.main.object(forInfoDictionaryKey: configKey.rawValue) as? String
    }
}

private extension Bundle {

    static var baseUrl: String {
        guard let baseUrl = value(for: .baseUrl) else {
            fatalError("Unable to retrieve BASE URL")
        }
        return baseUrl
    }

    static var apiKey: String {
        guard let apiKey = value(for: .apiKey) else {
            fatalError("Unable to retrieve API KEY")
        }
        return apiKey
    }
}
