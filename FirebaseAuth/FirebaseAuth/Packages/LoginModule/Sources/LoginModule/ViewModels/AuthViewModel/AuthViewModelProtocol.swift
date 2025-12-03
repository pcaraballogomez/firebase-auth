//
//  AuthViewModelProtocol.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 3/12/25.
//

import SwiftUI

@MainActor
protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
public protocol AuthViewModelProtocol: ObservableObject {
    var userSession: Any? { get } // lightweight representation
    var currentUser: User? { get }

    func signIn(withEmail email: String, password: String) async throws
    func createUser(withEmail email: String, password: String, fullName: String) async throws
    func signOut() throws
    func deleteAccount() async throws
}
