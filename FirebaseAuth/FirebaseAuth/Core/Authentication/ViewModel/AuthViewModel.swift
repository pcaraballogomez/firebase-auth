//
//  AuthViewModel.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?

    init() {
        userSession = Auth.auth().currentUser

        Task {
            await fetchUser()
        }
    }

    func signIn(withEmail email: String,
                password: String) async throws {
        print("sign in")
    }

    func createUser(withEmail email: String,
                    password: String,
                    fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email,
                                                          password: password)
            userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }

    func signOut() {

    }

    func deleteAccount() {

    }

    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid,
              let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {
            return
        }
        currentUser = try? snapshot.data(as: User.self)
        print("DEBUG: Current user is \(String(describing: currentUser))")
    }
}
