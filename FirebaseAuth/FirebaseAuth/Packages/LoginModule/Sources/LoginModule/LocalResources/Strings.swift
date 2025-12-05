import Foundation

extension LocalResources.Strings {

    struct Account {
        static let credentialsFailed = "account.error.credentials".localized
        static let unavailableSignIn = "account.error.unavailableSignIn".localized
    }

    struct Common {
        static let accept = "common.accept".localized
        static let delete = "common.delete".localized
        static let edit = "common.edit".localized
        static let error = "common.error".localized
        static let save = "common.save".localized
        static let tryAgainLater = "common.tryAgainLater".localized
    }

    struct Input {
        static let showPasswordAccessibilityLabel = "input.showPasswordAccessibilityLabel".localized
        static let hidePasswordAccessibilityLabel = "input.hidePasswordAccessibilityLabel".localized
    }

    struct Login {
        static let title = "login.title".localized
        static let email = "login.email".localized
        static let emailPlaceholder = "login.emailPlaceholder".localized
        static let password = "login.password".localized
        static let passwordPlaceholder = "login.passwordPlaceholder".localized
        static let signIn = "login.signIn".localized
        static let noAccount = "login.noAccount".localized
        static let signUp = "login.signUp".localized
    }

    struct Registration {
        static let title = "registration.title".localized
        static let email = "registration.email".localized
        static let emailPlaceholder = "registration.emailPlaceholder".localized
        static let fullName = "registration.fullName".localized
        static let fullNamePlaceholder = "registration.fullNamePlaceholder".localized
        static let password = "registration.password".localized
        static let passwordPlaceholder = "registration.passwordPlaceholder".localized
        static let confirmPassword = "registration.confirmPassword".localized
        static let confirmPasswordPlaceholder = "registration.confirmPasswordPlaceholder".localized
        static let signUp = "registration.signUp".localized
        static let haveAccount = "registration.haveAccount".localized
        static let signIn = "registration.signIn".localized
    }

    struct Validation {
        static let invalidEmail = "validation.invalidEmail".localized
        static let passwordTooShort = "validation.passwordTooShort".localized
        static let passwordMissingUppercase = "validation.passwordMissingUppercase".localized
        static let passwordMissingLowercase = "validation.passwordMissingLowercase".localized
        static let passwordMissingDigit = "validation.passwordMissingDigit".localized
        static let passwordsAreNotEqual = "validation.passwordsAreNotEqual".localized
    }
}
