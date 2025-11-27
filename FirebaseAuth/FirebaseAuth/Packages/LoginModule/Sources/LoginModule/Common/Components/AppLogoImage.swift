//
//  AppLogoImage.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 14/10/24.
//

import SwiftUI

struct AppLogoImage: View {

    private struct VisualConstants {
        static let iconWidth = 100.0
        static let iconHeight = 120.0
    }

    var body: some View {
        LocalResources.Images.App.icon
            .imageToFillModifiers()
            .frame(width: VisualConstants.iconWidth,
                   height: VisualConstants.iconHeight)
    }
}

#Preview {
    AppLogoImage()
}
