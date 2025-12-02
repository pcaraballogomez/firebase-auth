//
//  AuthViewModelKey.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 2/12/25.
//

import SwiftUI

public struct AuthViewModelKey: @preconcurrency EnvironmentKey {
    @MainActor
    public static let defaultValue: any AuthViewModelProtocol = {
        fatalError("""
        ❌ AuthViewModel not injected!
        You must use `.environment(\\.authViewModel, someViewModel)`
        in the app entry point.
        """)
    }()
}


public extension EnvironmentValues {

    var authViewModel: any AuthViewModelProtocol {
        get { self[AuthViewModelKey.self] }
        set { self[AuthViewModelKey.self] = newValue }
    }
}
