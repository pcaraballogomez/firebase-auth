//
//  InputView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 15/1/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecuredField = false
    var errorMessage: String?
    var textContentType: UITextContentType? = nil
    var keyboardType: UIKeyboardType = .default
    var endEditingAction: (() -> Void)?

    @State private var isPasswordVisible = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)

            if isSecuredField {
                secureTextField
            } else {
                standardTextField
            }

            if let errorMessage {
                InputErrorText(text: errorMessage)
            }

            Divider()
        }
    }

    // MARK: - Components

    private var secureTextField: some View {
        HStack {
            Group {
                if isPasswordVisible {
                    TextField(placeholder, text: $text)
                        .applyInputModifiers(
                            textContentType: textContentType,
                            keyboardType: keyboardType,
                            disableAutocorrection: true
                        )
                } else {
                    SecureField(placeholder, text: $text)
                        .applySecureInputModifiers(
                            textContentType: textContentType,
                            keyboardType: keyboardType
                        )
                }
            }
            .inputFieldHeight()

            if !text.isEmpty {
                eyeButton
                    .alignmentGuide(.firstTextBaseline) { dimension in
                        dimension[.bottom] / 2
                    }
            }
        }
        .frame(height: 30)
    }

    private var standardTextField: some View {
        TextField(placeholder, text: $text, onEditingChanged: { editingChanged in
            guard !editingChanged else { return }
            endEditingAction?()
        })
        .applyInputModifiers(
            textContentType: textContentType,
            keyboardType: keyboardType,
            disableAutocorrection: true
        )
        .inputFieldHeight()
    }

    private var eyeButton: some View {
        Button {
            isPasswordVisible.toggle()
        } label: {
            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                .foregroundColor(.black)
                .accessibilityLabel(isPasswordVisible ?
                                    Resources.Strings.Input.hidePasswordAccessibilityLabel : Resources.Strings.Input.showPasswordAccessibilityLabel)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            InputView(
                text: .constant(""),
                title: "Email Address",
                placeholder: "name@example.com"
            )

            InputView(
                text: .constant(""),
                title: "Contraseña",
                placeholder: "Ingresa tu contraseña",
                isSecuredField: true
            )

            InputView(
                text: .constant(""),
                title: "Contraseña con error",
                placeholder: "Ingresa tu contraseña",
                isSecuredField: true,
                errorMessage: "La contraseña es demasiado corta"
            )
        }
        .padding()
    }
}
