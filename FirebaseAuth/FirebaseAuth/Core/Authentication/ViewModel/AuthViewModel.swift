//
//  AuthViewModel.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?

    init() {

    }

    func signIn(withEmail email: String,
                password: String) async throws {
        print("sign in")
    }

    func createUser(withEmail email: String,
                    password: String,
                    fullName: String) async throws {
        print("create user")
    }

    func signOut() {

    }

    func deleteAccount() {

    }

    func fetchUser() async {
        
    }
}
