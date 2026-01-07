//
//  FirebaseAuthApp.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 15/1/24.
//

import FirebaseCore
import LoginModule
import LoginModuleFirebase
import SwiftUI

@main
struct FirebaseAuthApp: App {
    @StateObject var viewModel: AuthViewModel
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        FirebaseApp.configure()

        guard let googleClientID = FirebaseApp.app()?.options.clientID ?? Bundle.value(for: .googleClientID) else {
            fatalError("Missing Google Client ID in Firebase configuration or Info.plist")
        }
        let firebaseApiKey = FirebaseApp.app()?.options.apiKey
        let googleReversedClientID = Bundle.value(for: .googleReversedClientID)
        let config = LoginConfiguration(googleClientID: googleClientID,
                                        firebaseApiKey: firebaseApiKey,
                                        googleReversedClientID: googleReversedClientID)
        _viewModel = StateObject(wrappedValue: AuthViewModel(configuration: config))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environment(\.authViewModel, viewModel)
        }
    }
}
