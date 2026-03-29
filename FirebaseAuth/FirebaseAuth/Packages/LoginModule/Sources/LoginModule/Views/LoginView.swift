//
//  LoginView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 15/1/24.
//

import SwiftUI

public struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var emailErrorMessage: String?
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @Environment(\.authViewModel) private var viewModel: (any AuthViewModelProtocol)

    public init() {}

    public var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AppLogoImage()
                    .padding(.vertical, Constants.SpacingSize.XLSpacing)
                credentialInputFields
                signInActionButton
                signInWithGoogleButton
                Spacer()
                signUpNavigationLink
            }
        }
        .errorAlert(isPresented: $showErrorAlert,
                    errorMessage: errorMessage)
    }

    // MARK: - Subviews

    @ViewBuilder
    private var credentialInputFields: some View {
        VStack(spacing: Constants.SpacingSize.LSpacing) {
            InputView(text: $email,
                      title: LocalResources.Strings.Login.email.capitalized,
                      placeholder: LocalResources.Strings.Login.emailPlaceholder,
                      errorMessage: emailErrorMessage,
                      textContentType: .username,
                      keyboardType: .emailAddress,
                      endEditingAction: validateEmail)

            InputView(text: $password,
                      title: LocalResources.Strings.Login.password,
                      placeholder: LocalResources.Strings.Login.passwordPlaceholder,
                      isSecuredField: true,
                      textContentType: .password)
        }
        .padding(.horizontal)
        .padding(.top, Constants.SpacingSize.MSpacing)
    }

    @ViewBuilder
    private var signInActionButton: some View {
        ActionButton(text: LocalResources.Strings.Login.signIn,
                     systemImageName: .arrowRight) {
            Task {
                await handleSignIn()
            }
        }
        .addActionButtonStyles(isValid: formIsValid)
    }

    @ViewBuilder
    private var signUpNavigationLink: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            HStack(spacing: Constants.SpacingSize.SSpacing) {
                Text(LocalResources.Strings.Login.noAccount)
                Text(LocalResources.Strings.Login.signUp)
                    .fontWeight(.bold)
            }
            .font(.system(size: 14))
        }
    }

    @ViewBuilder
    private var signInWithGoogleButton: some View {
        SignInWithButton(provider: .google) {
            Task {
                do { try await viewModel.signInWithGoogle() }
                catch { showError(withMessage: error.localizedDescription) }
            }
        }
        .padding()
    }

    // MARK: - Private methods

    private func handleSignIn() async {
        do {
            try await viewModel.signIn(withEmail: email,
                                       password: password)
        } catch {
            showError(withMessage: LocalResources.Strings.Account.credentialsFailed +
                      error.localizedDescription)
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

extension LoginView: AuthenticationFormProtocol {

    var formIsValid: Bool {
        guard !password.isEmpty,
              case .success = Validator.validateEmail(email) else { return false }
        return true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
