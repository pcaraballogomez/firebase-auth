import Foundation

extension Bundle {

    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    /// Google Client ID from Info.plist (CLIENT_ID)
    var googleClientID: String? {
        return object(forInfoDictionaryKey: "CLIENT_ID") as? String
    }

    static func getBaseUrl(withKey: Bool = true) -> String {
        guard withKey else {
            return baseUrl
        }
        return baseUrl + "/" + apiKey
    }

    private static var baseUrl: String {
        guard let baseUrl = Bundle.main.object(
            forInfoDictionaryKey: Constants.ConfigKey.baseUrl.rawValue
        ) as? String else {
            fatalError("Unable to retrieve BASE URL")
        }
        return baseUrl
    }

    private static var apiKey: String {
        guard let apiKey = Bundle.main.object(
            forInfoDictionaryKey: Constants.ConfigKey.apiKey.rawValue
        ) as? String else {
            fatalError("Unable to retrieve API KEY")
        }
        return apiKey
    }
}
