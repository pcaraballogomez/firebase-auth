import Foundation

extension Resources.Strings {

    struct Account {
        static let unavailableSignIn = "account.error.unavailableSignIn".localized
        static let unavailableAccountDeletion = "account.error.unavailableAccountDeletion".localized
        static let unavailableSigningOut = "account.error.unavailableSigningOut".localized
    }

    struct Common {
        static let accept = "common.accept".localized
        static let delete = "common.delete".localized
        static let edit = "common.edit".localized
        static let error = "common.error".localized
        static let loading = "common.loading".localized
        static let save = "common.save".localized
        static let tryAgainLater = "common.tryAgainLater".localized
    }

    struct Profile {
        static let title = "profile.title".localized
        static let version = "profile.version".localized
        static let signOut = "profile.signOut".localized
        static let deleteAccount = "profile.deleteAccount".localized
        static let confirmDeleteAccount = "profile.confirmDeleteAccount".localized

        // Sections
        static let general = "profile.section.general".localized
        static let account = "profile.section.account".localized
    }
}
