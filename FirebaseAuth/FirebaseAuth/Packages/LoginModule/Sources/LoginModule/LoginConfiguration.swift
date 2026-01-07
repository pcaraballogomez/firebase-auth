//
//  LoginConfig.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 5/1/26.
//

import Foundation

/// Public configuration object for LoginModule. Provide all required values here to avoid implicit bundle reads.
public struct LoginConfiguration {
    public let firebaseApiKey: String?
    public let googleClientID: String
    public let googleReversedClientID: String?

    public init(googleClientID: String,
                firebaseApiKey: String? = nil,
                googleReversedClientID: String? = nil) {
        self.googleClientID = googleClientID
        self.firebaseApiKey = firebaseApiKey
        self.googleReversedClientID = googleReversedClientID
    }
}
