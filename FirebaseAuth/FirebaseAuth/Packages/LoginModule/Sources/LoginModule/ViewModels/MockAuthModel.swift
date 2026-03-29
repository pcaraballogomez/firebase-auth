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
        #if DEBUG
        print("Preview mock signIn invoked")
        #endif
    }

    public func signInWithGoogle() async throws {
        #if DEBUG
        print("Preview mock signInWithGoogle invoked")
        #endif
    }

    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        #if DEBUG
        print("Preview mock createUser invoked")
        #endif
    }

    func signOut() throws {
        #if DEBUG
        print("Preview mock signOut invoked")
        #endif
    }

    func deleteAccount() async throws {
        #if DEBUG
        print("Preview mock deleteAccount invoked")
        #endif
    }
}
