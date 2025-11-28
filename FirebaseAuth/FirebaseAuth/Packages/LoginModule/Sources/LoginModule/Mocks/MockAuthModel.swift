//
//  MockAuthModel.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 28/11/25.
//

import Foundation

@MainActor
class MockAuthViewModel: ObservableObject, AuthViewModelProtocol {
    @Published var currentUser: User? = nil
    @Published var userSession: Any? = nil

    private let persistency = MockUserPersistencyService()

    func signIn(withEmail email: String, password: String) async throws {
        print("Preview mock signIn invoked")
    }

    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        print("Preview mock createUser invoked")
    }

    func signOut() throws {
        print("Preview mock signOut invoked")
    }

    func deleteAccount() async throws {
        print("Preview mock deleteAccount invoked")
    }
}
