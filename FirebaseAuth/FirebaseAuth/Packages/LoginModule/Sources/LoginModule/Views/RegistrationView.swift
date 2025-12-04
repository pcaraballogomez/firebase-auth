//
//  RegistrationView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var emailErrorMessage: String?
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.authViewModel) private var viewModel: any AuthViewModelProtocol

    public init() {}

    var body: some View {
        VStack {
            AppLogoImage()
                .padding(.vertical, Constants.SpacingSize.XLSpacing)
            registrationForm
            signUpActionButton
            Spacer()
            dismissButton
        }
        .errorAlert(isPresented: $showErrorAlert,
                    errorMessage: errorMessage)
    }

    // MARK: - Subviews

    @ViewBuilder
    private var registrationForm: some View {
        VStack(spacing: Constants.SpacingSize.MSpacing) {
            InputView(text: $email,
                      title: LocalResources.Strings.Registration.email,
                      placeholder: LocalResources.Strings.Registration.emailPlaceholder,
                      errorMessage: emailErrorMessage,
                      endEditingAction: {
                validateEmail()
            })

            InputView(text: $fullName,
                      title: LocalResources.Strings.Registration.fullName,
                      placeholder: LocalResources.Strings.Registration.fullNamePlaceholder)

            InputView(text: $password,
                      title: LocalResources.Strings.Registration.password,
                      placeholder: LocalResources.Strings.Registration.passwordPlaceholder,
                      isSecuredField: true)

            ZStack(alignment: .trailing) {
                InputView(text: $confirmPassword,
                          title: LocalResources.Strings.Registration.confirmPassword,
                          placeholder: LocalResources.Strings.Registration.confirmPasswordPlaceholder,
                          isSecuredField: true,
                          trailingContent: {
                    if !confirmPassword.isEmpty {
                        passwordConfirmationImage
                    }
                })
            }

            if !confirmPassword.isEmpty,
               case let .failure(error) = Validator.validatePassword(password,
                                                                     andConfirmation: confirmPassword),
               let errorText = error.errorDescription {
                InputErrorText(text: errorText)
            }
        }
        .padding(.horizontal)
        .padding(.top, Constants.SpacingSize.MSpacing)
    }

    @ViewBuilder
    private var passwordConfirmationImage: some View {
        switch Validator.validatePassword(password,
                                          andConfirmation: confirmPassword) {
        case .success:
            Image(imageSystemName: .checkmarkCircleFill)
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemGreen))
        case .failure:
            Image(imageSystemName: .xMarkCircleFill)
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemRed))
        }
    }

    @ViewBuilder
    private var signUpActionButton: some View {
        ActionButton(text: LocalResources.Strings.Registration.signUp,
                     systemImageName: .arrowRight) {
            Task {
                do {
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullName: fullName)
                } catch {
                    showError(withMessage: LocalResources.Strings.Account.credentialsFailed +
                              error.localizedDescription)
                }
            }
        }
        .addActionButtonStyles(isValid: formIsValid)
    }

    @ViewBuilder
    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: Constants.SpacingSize.SSpacing) {
                Text(LocalResources.Strings.Registration.haveAccount)
                Text(LocalResources.Strings.Registration.signIn)
                    .fontWeight(.bold)
            }
            .font(.system(size: 14))
        }
    }

    private func showError(withMessage message: String) {
        errorMessage = message
        showErrorAlert = true
    }

    private func validateEmail() {
        guard case let .failure(error) = Validator.validateEmail(email) else {
            emailErrorMessage = nil
            return
        }
        emailErrorMessage = error.errorDescription
    }
}

// MARK: - AuthenticationFormProtocol

extension RegistrationView: AuthenticationFormProtocol {

    var formIsValid: Bool {
        guard !fullName.isEmpty else { return false }
        switch (Validator.validateEmail(email),
                Validator.validatePassword(password, andConfirmation: confirmPassword)) {
        case (.success, .success): return true
        default: return false
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
