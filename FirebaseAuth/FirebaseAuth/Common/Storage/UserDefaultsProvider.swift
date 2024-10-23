//
//  UserDefaultsProvider.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 5/3/24.
//

import Foundation

protocol UserDefaultsProviderProtocol {
    func save<T: Codable>(_ value: T, forKey key: UserDefaultsKey)
    func load<T: Codable>(_ type: T.Type, forKey key: UserDefaultsKey) -> T?
}

enum UserDefaultsKey: String {
    case bookmarks
}

class UserDefaultsProvider: UserDefaultsProviderProtocol {
    private let userDefaults = UserDefaults.standard

    func save<T: Codable>(_ value: T, forKey key: UserDefaultsKey) {
        guard let encodedData = try? JSONEncoder().encode(value) else { return }
        userDefaults.set(encodedData, forKey: key.rawValue)
    }

    func load<T: Codable>(_ type: T.Type, forKey key: UserDefaultsKey) -> T? {
        guard let encodedData = userDefaults.data(forKey: key.rawValue),
              let decodedValue = try? JSONDecoder().decode(type, from: encodedData) else {
            return nil
        }
        return decodedValue
    }
}
