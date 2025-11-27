//
//  PersistencyServiceProtocol.swift
//  WeeklyMenu
//
//  Created by Pablo Caraballo Gómez on 14/10/24.
//

import Foundation
import FirebaseFirestore

protocol PersistencyServiceProtocol: UserPersistencyServiceProtocol {}

@MainActor
protocol UserPersistencyServiceProtocol {
    var collectionName: String { get }
    func fetchUser(withId id: String) async throws -> User
    func createUser(_ user: User) async throws
    func deleteUser(withId id: String) async throws
    func getUserDocument(byUserId id: String) -> DocumentReference
}
