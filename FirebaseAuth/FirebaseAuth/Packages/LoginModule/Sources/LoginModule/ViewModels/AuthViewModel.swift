//
//  AuthViewModel.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import Foundation
import Firebase
@preconcurrency import FirebaseAuth
import FirebaseFirestore

@MainActor
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
public protocol AuthViewModelProtocol {
    func signIn(withEmail email: String, password: String) async throws
    func createUser(withEmail email: String, password: String, fullName: String) async throws
    func signOut() throws
    func deleteAccount() async throws
}

@MainActor
public class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    private let userPersistencyService: UserPersistencyServiceProtocol

    init(userPersistencyService: UserPersistencyServiceProtocol = FirestoreUserPersistencyService()) {
        self.userPersistencyService = userPersistencyService
        userSession = Auth.auth().currentUser

        Task {
            await fetchUserIfNeeded()
        }
    }
}

extension AuthViewModel: AuthViewModelProtocol {

    public func signIn(withEmail email: String,
                       password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email,
                                                  password: password)
        try await handleUserSession(result: result)
    }

    public func createUser(withEmail email: String,
                           password: String,
                           fullName: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email,
                                                      password: password)
        let user = User(id: result.user.uid, fullName: fullName, email: email)
        try await userPersistencyService.createUser(user)
        try await handleUserSession(result: result)
    }

    public func signOut() throws {
        try Auth.auth().signOut()
        clearUserSession()
    }

    public func deleteAccount() async throws {
        guard let id = Auth.auth().currentUser?.uid else { throw AuthError.noCurrentUser }
        try await userPersistencyService.deleteUser(withId: id)
        try signOut()
    }
}

// MARK: - Private methods
private extension AuthViewModel {

    func fetchUserIfNeeded() async {
        guard userSession != nil else { return }
        await fetchUser()
    }

    func fetchUser() async {
        guard let id = Auth.auth().currentUser?.uid else {
            return
        }
        currentUser = try? await userPersistencyService.fetchUser(withId: id)
        print("DEBUG: Current user is \(String(describing: currentUser))")
    }

    func handleUserSession(result: AuthDataResult) async throws {
        userSession = result.user
        await fetchUser()
    }

    func clearUserSession() {
        userSession = nil
        currentUser = nil
    }
}

// MARK: - Errors

public enum AuthError: Error {
    case noCurrentUser
}
