//
//  AuthViewModel.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import Firebase
@preconcurrency import FirebaseAuth
import FirebaseFirestore
import Foundation
import GoogleSignIn
import LoginModule

@MainActor
public class AuthViewModel: AuthViewModelProtocol {

    @Published public var currentUser: LoginModule.User?
    @Published private var _userSession: FirebaseAuth.User?

    public var userSession: Any? { _userSession }
    private let configuration: LoginConfiguration
    private let userPersistencyService: UserPersistencyServiceProtocol

    public init(configuration: LoginConfiguration,
                userPersistencyService: UserPersistencyServiceProtocol = FirestoreUserPersistencyService()) {
        self.configuration = configuration
        self.userPersistencyService = userPersistencyService
        _userSession = Auth.auth().currentUser

        Task {
            await fetchUserIfNeeded()
        }
    }

    public func signIn(withEmail email: String,
                       password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email,
                                                  password: password)
        try await handleUserSession(result: result)
    }

    public func signInWithGoogle() async throws {
        let (idToken, accessToken) = try await performGoogleSignIn(clientID: configuration.googleClientID)
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)
        let result = try await Auth.auth().signIn(with: credential)
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

    func fetchUser(uid: String? = nil) async {
        let userId = uid ?? Auth.auth().currentUser?.uid
        guard let userId else { return }

        currentUser = try? await userPersistencyService.fetchUser(withId: userId)
        print("DEBUG: Current user is \(String(describing: currentUser))")
    }

    func handleUserSession(result: AuthDataResult) async throws {
        _userSession = result.user
        await fetchUser(uid: result.user.uid)
        if currentUser == nil {
            // If there's no user document (e.g., Google sign-in), create one from auth info
            await createUser(using: result)
        }
    }

    func createUser(using result: AuthDataResult) async {
        let fullName = result.user.displayName ?? ""
        let email = result.user.email ?? ""
        let user = User(id: result.user.uid,
                        fullName: fullName,
                        email: email)
        do {
            try await userPersistencyService.createUser(user)
            currentUser = user
        } catch {
            print("DEBUG: Error - failed to create user document: \(error)")
        }
    }

    func clearUserSession() {
        _userSession = nil
        currentUser = nil
    }

    nonisolated func performGoogleSignIn(clientID: String) async throws -> (String, String) {
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = await windowScene.keyWindow?.rootViewController else {
            throw URLError(.cannotFindHost)
        }

        guard !clientID.isEmpty else {
            throw URLError(.userAuthenticationRequired)
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
        guard let idToken = signInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        return (idToken, signInResult.user.accessToken.tokenString)
    }
}

// MARK: - Errors

public enum AuthError: Error {
    case noCurrentUser
}
