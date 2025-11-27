//
//  Image+Extension.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 9/2/24.
//

import SwiftUI

extension Image {

    init(imageSystemName: Constants.ImageSystemName) {
        self.init(systemName: imageSystemName.rawValue)
    }

    func imageToFitModifiers() -> some View {
        self
            .resizable()
            .scaledToFit()
    }

    func imageToFillModifiers() -> some View {
        self
            .resizable()
            .scaledToFill()
    }

    func iconModifiers() -> some View {
        self
            .imageToFitModifiers()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}
