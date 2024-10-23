//
//  FirestoreService.swift
//  WeeklyMenu
//
//  Created by Pablo Caraballo Gómez on 14/10/24.
//

import Foundation
import FirebaseFirestore

class FirestorePersistencyService: PersistencyServiceProtocol {
    var collectionName: String = "users"
    private let database = Firestore.firestore()

    func fetchUser(withId id: String) async throws -> User? {
        let snapshot = try await getFirestoreDocument(byUserId: id).getDocument()
        return try snapshot.data(as: User.self)
    }

    func createUser(_ user: User) async throws {
        let encodedUser = try Firestore.Encoder().encode(user)
        try await getFirestoreDocument(byUserId: user.id).setData(encodedUser)
    }

    func deleteUser(withId id: String) async throws {
        try await getFirestoreDocument(byUserId: id).delete()
    }

    private func getFirestoreDocument(byUserId id: String) -> DocumentReference {
        database.collection(collectionName).document(id)
    }
}
