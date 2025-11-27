//
//  FirestoreUserPersistencyService.swift
//  WeeklyMenu
//
//  Created by Pablo Caraballo Gómez on 14/10/24.
//

import Foundation
@preconcurrency import FirebaseFirestore

class FirestoreUserPersistencyService: UserPersistencyServiceProtocol {
    var collectionName: String = "users"
    private let database = Firestore.firestore()

    func fetchUser(withId id: String) async throws -> User {
        let snapshot = try await getUserDocument(byUserId: id).getDocument()
        return try snapshot.data(as: User.self)
    }

    func createUser(_ user: User) async throws {
        let encodedUser = try Firestore.Encoder().encode(user)
        try await getUserDocument(byUserId: user.id).setData(encodedUser)
    }

    func deleteUser(withId id: String) async throws {
        try await getUserDocument(byUserId: id).delete()
    }

    func getUserDocument(byUserId id: String) -> DocumentReference {
        database.collection(collectionName).document(id)
    }
}
