import SwiftUI

extension LocalResources.Colors {

    struct Common {

        private static func colorNamed(_ name: String) -> Color {
            guard let uiColor = UIColor(named: name,
                                        in: .module,
                                        compatibleWith: nil) else {
                return Color(name)
            }
            return Color(uiColor)
        }

        static let backgroundPrimary = colorNamed("background_primary")
        static let backgroundSecondary = colorNamed("background_secondary")
        static let textPrimary = colorNamed("text_primary")
        static let textSecondary = colorNamed("text_secondary")
        static let borderPrimary = colorNamed("border_primary")
    }
}
