//
//  ProfileView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    if let initials = User.MOCK_USER.initials {
                        Text(initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(User.MOCK_USER.fullName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)

                        Text(User.MOCK_USER.email)
                            .font(.footnote)
                            .foregroundColor(.gray)
//                            .accentColor(.gray)
                    }
                }
            }

            Section("General") {
                HStack {
                    SettingsRowView(systemImageName: "gear",
                                    title: "Version",
                                    tintColor: Color(.systemGray))

                    Spacer()

                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            Section("Account") {
                Button {
                    print("Sign out...")
                } label: {
                    SettingsRowView(systemImageName: "arrow.left.circle.fill",
                                    title: "Sign Out",
                                    tintColor: .red)
                }

                Button {
                    print("Delete account...")
                } label: {
                    SettingsRowView(systemImageName: "xmark.circle.fill",
                                    title: "Delete account",
                                    tintColor: .red)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
