//
//  LoginView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 15/1/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AppLogoImage()
                    .padding(.vertical, Constants.SpacingSize.XLSpacing)
                credentialInputFields
                signInActionButton
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
                      title: Resources.Strings.Login.email.capitalized,
                      placeholder: Resources.Strings.Login.emailPlaceholder)

            InputView(text: $password,
                      title: Resources.Strings.Login.password,
                      placeholder: Resources.Strings.Login.passwordPlaceholder,
                      isSecuredField: true)
        }
        .padding(.horizontal)
        .padding(.top, Constants.SpacingSize.MSpacing)
    }

    @ViewBuilder
    private var signInActionButton: some View {
        ActionButton(text: Resources.Strings.Login.signIn,
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
                Text(Resources.Strings.Login.noAccount)
                Text(Resources.Strings.Login.signUp)
                    .fontWeight(.bold)
            }
            .font(.system(size: 14))
        }
    }

    // MARK: - Private methods

    private func handleSignIn() async {
        do {
            try await viewModel.signIn(withEmail: email,
                                       password: password)
        } catch {
            showError(withMessage: Resources.Strings.Account.credentialsFailed +
                      error.localizedDescription)
        }
    }

    private func showError(withMessage message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}

// MARK: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {

    var formIsValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
