//
//  InputErrorText.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 23/10/24.
//

import SwiftUI

struct InputErrorText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundColor(.red)
    }
}

#Preview {
    InputErrorText(text: "Test")
}
