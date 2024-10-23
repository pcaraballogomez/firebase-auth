//
//  ErrorAlertView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 14/10/24.
//

import SwiftUI

struct ErrorAlertView: ViewModifier {
    @Binding var isPresented: Bool
    let errorMessage: String

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text("Error"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
}

extension View {
    func errorAlert(isPresented: Binding<Bool>, errorMessage: String) -> some View {
        modifier(ErrorAlertView(isPresented: isPresented, errorMessage: errorMessage))
    }
}
