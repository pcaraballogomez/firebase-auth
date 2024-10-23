//
//  Validator.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 22/10/24.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidEmail
    case passwordTooShort
    case passwordMissingUppercase
    case passwordMissingLowercase
    case passwordMissingDigit
    case passwordsAreNotEqual

    var errorDescription: String {
        switch self {
        case .invalidEmail:
            return Resources.Strings.Validation.invalidEmail
        case .passwordTooShort:
            return Resources.Strings.Validation.passwordTooShort
        case .passwordMissingUppercase:
            return Resources.Strings.Validation.passwordMissingUppercase
        case .passwordMissingLowercase:
            return Resources.Strings.Validation.passwordMissingLowercase
        case .passwordMissingDigit:
            return Resources.Strings.Validation.passwordMissingDigit
        case .passwordsAreNotEqual:
            return Resources.Strings.Validation.passwordsAreNotEqual
        }
    }
}

struct Validator {

    static let passwordMinNumOfChars = 8

    static func validateEmail(_ email: String) -> Result<Void, ValidationError> {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email) ? .success(()) : .failure(.invalidEmail)
    }

    static func validatePassword(_ password: String) -> Result<Void, ValidationError> {
        guard password.count >= passwordMinNumOfChars else {
            return .failure(.passwordTooShort)
        }
        guard password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
            return .failure(.passwordMissingUppercase)
        }
        guard password.rangeOfCharacter(from: .lowercaseLetters) != nil else {
            return .failure(.passwordMissingLowercase)
        }
        guard password.rangeOfCharacter(from: .decimalDigits) != nil else {
            return .failure(.passwordMissingDigit)
        }
        return .success(())
    }

    static func validatePassword(_ password: String,
                                 andConfirmation confirmationPassword: String) -> Result<Void, ValidationError> {
        let result = Validator.validatePassword(password)
        guard case .success = result else {
            return result
        }
        return password == confirmationPassword ? .success(()) : .failure(.passwordsAreNotEqual)
    }
}
