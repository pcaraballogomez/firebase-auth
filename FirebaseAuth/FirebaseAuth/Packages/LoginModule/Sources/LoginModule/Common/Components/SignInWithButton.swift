//
//  SignInWithButton.swift
//  LoginModule
//
//  Created by Pablo Caraballo Gómez on 9/12/25.
//

import SwiftUI

public struct SignInWithButton: View {

    public enum Provider: String {
        case apple
        case facebook
        case google

        var icon: Image {
            switch self {
            case .apple: return LocalResources.Images.LoginProvider.appleLogo
            case .facebook: return LocalResources.Images.LoginProvider.facebookLogo
            case .google: return LocalResources.Images.LoginProvider.googleLogo
            }
        }

        var title: String { self.rawValue.capitalized }
    }

    let provider: Provider
    let action: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    public init(provider: Provider,
                action: @escaping () -> Void) {
        self.provider = provider
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                provider.icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.Size.iconSize,
                           height: Constants.Size.iconSize)

                Text(String(format: LocalResources.Strings.Login.signInWithPrefix, provider.title))
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(LocalResources.Colors.Common.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(LocalResources.Colors.Common.backgroundSecondary)
            .cornerRadius(28)
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(LocalResources.Colors.Common.borderPrimary, lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

//#Preview("Google Light") {
//    SignInWithButton(provider: .google) {
//        print("Google Sign In")
//    }
//    .preferredColorScheme(.light)
//}
//
//#Preview("Google Dark") {
//    SignInWithButton(provider: .google) {
//        print("Google Sign In")
//    }
//    .preferredColorScheme(.dark)
//}

#Preview("Apple Light") {
    SignInWithButton(provider: .apple) {
        print("Apple Sign In")
    }
    .preferredColorScheme(.light)
}

#Preview("Apple Dark") {
    SignInWithButton(provider: .apple) {
        print("Apple Sign In")
    }
    .preferredColorScheme(.dark)
}
