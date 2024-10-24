//
//  ErrorAlertViewModifier.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 14/10/24.
//

import SwiftUI

struct ErrorAlertViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let errorMessage: String

    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(Resources.Strings.Common.error),
                    message: Text(errorMessage),
                    dismissButton: .default(Text(Resources.Strings.Common.accept))
                )
            }
    }
}

extension View {
    func errorAlert(isPresented: Binding<Bool>, errorMessage: String) -> some View {
        modifier(ErrorAlertViewModifier(isPresented: isPresented,
                                        errorMessage: errorMessage))
    }
}
