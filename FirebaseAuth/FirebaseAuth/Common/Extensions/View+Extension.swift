//
//  View+Extension.swift
//  FirebaseAuth-foo
//
//  Created by Pablo Caraballo Gómez on 26/11/25.
//

import SwiftUI

struct InputFieldModifier: ViewModifier {
    let textContentType: UITextContentType?
    let keyboardType: UIKeyboardType
    let disableAutocorrection: Bool

    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .textContentType(textContentType)
            .keyboardType(keyboardType)
            .autocapitalization(.none)
            .textInputAutocapitalization(.never)
            .applyIf(disableAutocorrection) { view in
                view.autocorrectionDisabled()
            }
    }
}

extension View {

    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    func applyInputModifiers(
        textContentType: UITextContentType? = nil,
        keyboardType: UIKeyboardType = .default,
        disableAutocorrection: Bool = false
    ) -> some View {
        self.modifier(InputFieldModifier(
            textContentType: textContentType,
            keyboardType: keyboardType,
            disableAutocorrection: disableAutocorrection
        ))
    }

    func applySecureInputModifiers(
        textContentType: UITextContentType? = nil,
        keyboardType: UIKeyboardType = .default
    ) -> some View {
        self.modifier(InputFieldModifier(
            textContentType: textContentType,
            keyboardType: keyboardType,
            disableAutocorrection: false
        ))
    }

    func inputFieldHeight() -> some View {
        self.frame(minHeight: 30)
    }
}
