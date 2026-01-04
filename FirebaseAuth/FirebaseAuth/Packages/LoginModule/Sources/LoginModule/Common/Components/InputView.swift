//
//  InputView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 15/1/24.
//

import SwiftUI

struct InputView<TrailingContent: View>: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecuredField = false
    var errorMessage: String?
    var textContentType: UITextContentType? = nil
    var keyboardType: UIKeyboardType = .default
    var endEditingAction: (() -> Void)?
    var trailingContent: (() -> TrailingContent)?

    @State private var isPasswordVisible = false

    init(text: Binding<String>,
         title: String,
         placeholder: String,
         isSecuredField: Bool = false,
         errorMessage: String? = nil,
         textContentType: UITextContentType? = nil,
         keyboardType: UIKeyboardType = .default,
         endEditingAction: (() -> Void)? = nil) where TrailingContent == EmptyView {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.isSecuredField = isSecuredField
        self.errorMessage = errorMessage
        self.textContentType = textContentType
        self.keyboardType = keyboardType
        self.endEditingAction = endEditingAction
        self.trailingContent = nil
    }

    init(text: Binding<String>,
         title: String,
         placeholder: String,
         isSecuredField: Bool = false,
         errorMessage: String? = nil,
         textContentType: UITextContentType? = nil,
         keyboardType: UIKeyboardType = .default,
         endEditingAction: (() -> Void)? = nil,
         @ViewBuilder trailingContent: @escaping () -> TrailingContent) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.isSecuredField = isSecuredField
        self.errorMessage = errorMessage
        self.textContentType = textContentType
        self.keyboardType = keyboardType
        self.endEditingAction = endEditingAction
        self.trailingContent = trailingContent
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(LocalResources.Colors.Common.textPrimary)
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

            HStack(spacing: 8) {
                if let trailingContent = trailingContent {
                    trailingContent()
                }

                if !text.isEmpty {
                    eyeButton
                }
            }
            .alignmentGuide(.firstTextBaseline) { dimension in
                dimension[.bottom] / 2
            }
        }
        .frame(height: Constants.Size.textFieldHeight)
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
                .foregroundColor(LocalResources.Colors.Common.textPrimary)
                .accessibilityLabel(isPasswordVisible ?
                                    LocalResources.Strings.Input.hidePasswordAccessibilityLabel : LocalResources.Strings.Input.showPasswordAccessibilityLabel)
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
