//
//  ActionButton.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 14/10/24.
//

import SwiftUI

struct ActionButton: View {
    let text: String
    let systemImageName: Constants.ImageSystemName?
    let action: (() -> Void)?
    var body: some View {
        Button {
            action?()
        } label: {
            HStack {
                Text(text.uppercased())
                    .fontWeight(.semibold)
                if let systemImageName {
                    Image(imageSystemName: systemImageName)
                }
            }
            .foregroundColor(.white)
            .frame(width: Constants.Size.allScreenWidth,
                   height: Constants.Size.buttonHeight)
        }
    }
}

#Preview {
    ActionButton(text: LocalResources.Strings.Login.signIn,
                 systemImageName: .arrowRight,
                 action: nil)
        .background(Color(.systemBlue))
        .cornerRadius(Constants.Size.cornerRadius)
}
