//
//  User.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String

    var initials: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: fullName) else { return nil }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString,
                                fullName: "Pablo Caraballo",
                                email: "pcaraballogomez@gmail.com")
}
