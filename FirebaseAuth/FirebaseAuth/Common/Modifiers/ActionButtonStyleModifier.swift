//
//  ActionButtonStyleModifier.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 15/10/24.
//

import SwiftUI

struct ActionButtonStyleModifier: ViewModifier {
    let isValid: Bool

    func body(content: Content) -> some View {
        content
            .disabled(!isValid)
            .opacity(Constants.Opacity.when(isValid: isValid))
            .background(Color(.systemBlue).opacity(Constants.Opacity.when(isValid: isValid)))
            .cornerRadius(Constants.Size.cornerRadius)
            .padding(.top, Constants.SpacingSize.LSpacing)
    }
}

extension View {
    func addActionButtonStyles(isValid: Bool) -> some View {
        modifier(ActionButtonStyleModifier(isValid: isValid))
    }
}
