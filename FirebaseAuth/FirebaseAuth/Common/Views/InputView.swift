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
    var endEditingAction: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)

            if isSecuredField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text, onEditingChanged: { editingChanged in
                    guard !editingChanged else { return }
                    endEditingAction?()
                })
                    .font(.system(size: 14))
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
            }

            if let errorMessage {
                InputErrorText(text: errorMessage)
            }

            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""),
                  title: "Email Address",
                  placeholder: "name@example.com")
    }
}
