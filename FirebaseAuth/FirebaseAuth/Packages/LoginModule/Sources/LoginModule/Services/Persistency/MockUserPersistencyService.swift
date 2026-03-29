//
//  MockUserPersistencyService.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 28/11/25.
//

class MockUserPersistencyService: UserPersistencyServiceProtocol {

    var collectionName: String { "mockUsers"}
    
    func fetchUser(withId id: String) async throws -> User {
        User(id: "123", fullName: "Preview User", email: "preview@test.com")
    }

    func createUser(_ user: User) async throws {
        #if DEBUG
        print("Mock createUser")
        #endif
    }

    func deleteUser(withId id: String) async throws {
        #if DEBUG
        print("Mock deleteUser")
        #endif
    }
}
