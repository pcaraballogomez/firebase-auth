import SwiftUI

extension LocalResources.Images {

    struct Common {
        static let greenCheck = Image("ic_check_green_circle", bundle: .module)
    }

    struct App {
        static let icon = Image("ic_app", bundle: .module)
    }

    struct LoginProvider {
        static let appleLogo = Image("apple_logo", bundle: .module)
        static let facebookLogo = Image("facebook_logo", bundle: .module)
        static let googleLogo = Image("google_logo", bundle: .module)
    }
}
