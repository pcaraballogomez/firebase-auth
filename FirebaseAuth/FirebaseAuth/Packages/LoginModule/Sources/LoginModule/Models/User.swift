//
//  User.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import Foundation

public struct User: Identifiable, Codable, Sendable {
    public let id: String
    public let fullName: String
    public let email: String

    public init(id: String, fullName: String, email: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
    }

    public var initials: String? {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: fullName) else { return nil }
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
}
