//
//  ProfileView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import LoginModule
import LoginModuleFirebase
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @State private var showDeleteConfirmation = false

    private struct VisualConstants {
        static let spacing = 4.0
    }

    var body: some View {
        if let user = viewModel.currentUser {
            List {
                userInfoSection(user)
                if let version = Bundle.main.releaseVersionNumber {
                    generalSettingsSection(version)
                }
                accountActionsSection()
            }
            .errorAlert(isPresented: $showErrorAlert,
                        errorMessage: errorMessage)
        } else {
            LoadingDotsView()
        }
    }

    // MARK: - User info section
    @ViewBuilder
    private func userInfoSection(_ user: User) -> some View {
        Section {
            HStack {
                UserAvatar(initials: user.initials)

                VStack(alignment: .leading, spacing: VisualConstants.spacing) {
                    Text(user.fullName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top, VisualConstants.spacing)

                    Text(user.email)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    // MARK: - General settings section
    @ViewBuilder
    private func generalSettingsSection(_ version: String) -> some View {
        Section(Resources.Strings.Profile.general) {
            HStack {
                SettingsRowView(imageSystemName: .gear,
                                title: Resources.Strings.Profile.version,
                                tintColor: Color(.systemGray))
                Spacer()
                Text(version)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }

    // MARK: - Account actions section
    @ViewBuilder
    private func accountActionsSection() -> some View {
        Section(Resources.Strings.Profile.account) {
            Button {
                do {
                    try viewModel.signOut()
                } catch {
                    showError(withMessage: Resources.Strings.Account.unavailableSigningOut +
                              Resources.Strings.Common.tryAgainLater)
                }
            } label: {
                SettingsRowView(imageSystemName: .arrowLeftCircleFill,
                                title: Resources.Strings.Profile.signOut,
                                tintColor: .red)
            }

            Button {
                showDeleteConfirmation = true
            } label: {
                SettingsRowView(imageSystemName: .xMarkCircleFill,
                                title: Resources.Strings.Profile.deleteAccount,
                                tintColor: .red)
            }
            .alert(isPresented: $showDeleteConfirmation) {
                deleteConfirmationAlert
            }
        }
    }

    // MARK: - Delete confirmation alert
    private var deleteConfirmationAlert: Alert {
        Alert(
            title: Text(Resources.Strings.Profile.deleteAccount),
            message: Text(Resources.Strings.Profile.confirmDeleteAccount),
            primaryButton: .destructive(Text(Resources.Strings.Common.delete)) {
                deleteAccount()
            },
            secondaryButton: .cancel()
        )
    }

    // MARK: - Private methods

    private func deleteAccount() {
        Task {
            do {
                try await viewModel.deleteAccount()
            } catch {
                showError(withMessage: Resources.Strings.Account.unavailableAccountDeletion +
                          Resources.Strings.Common.tryAgainLater)
            }
        }
    }

    private func showError(withMessage message: String) {
        errorMessage = message
        showErrorAlert = true
    }
}

struct ProfileView_Previews: PreviewProvider {

    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
