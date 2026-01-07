//
//  ContentView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 15/1/24.
//

import LoginModule
import LoginModuleFirebase
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel(configuration: LoginConfiguration(googleClientID: "preview-client-id")))
    }
}
