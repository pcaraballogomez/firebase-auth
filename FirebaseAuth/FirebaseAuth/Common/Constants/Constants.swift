import SwiftUI

enum Constants {

    enum ConfigKey: String {
        case baseUrl = "BASE_URL"
        case apiKey = "API_KEY"
    }

    enum Image: String {
        case previewPath = "/preview"
    }

    enum ImageSystemName: String {
        case arrowLeftCircleFill = "arrow.left.circle.fill"
        case arrowRight = "arrow.right"
        case antCircleFill = "ant.circle.fill"
        case bookmark = "bookmark"
        case bookmarkFill = "bookmark.fill"
        case calendar = "calendar"
        case carrot = "carrot"
        case checkmarkCircleFill = "checkmark.circle.fill"
        case forkKnifeCircle = "fork.knife.circle"
        case forkKnifeCircleFill = "fork.knife.circle.fill"
        case gear = "gear"
        case magnifyingglass = "magnifyingglass"
        case mug = "mug"
        case photoCircleFill = "photo.circle.fill"
        case plusCircleFill = "plus.circle.fill"
        case profileCropCircle = "person.crop.circle"
        case trash = "trash"
        case xMarkCircleFill = "xmark.circle.fill"
    }

    struct Opacity {
        static let validOpacity = 1.0
        static let invalidOpacity = 0.5

        static func when(isValid: Bool) -> CGFloat {
            isValid ? validOpacity : invalidOpacity
        }
    }

    struct Size {
        static let allScreenWidth = UIScreen.main.bounds.width - SpacingSize.XLSpacing
        static let buttonHeight = 48.0
        static let cornerRadius = 10.0
        static let imageWidth = 80.0
    }

    struct SpacingSize {
        static let XLSpacing = 32.0
        static let LSpacing = 24.0
        static let MSpacing = 12.0
        static let SSpacing = 3.0
    }
}
