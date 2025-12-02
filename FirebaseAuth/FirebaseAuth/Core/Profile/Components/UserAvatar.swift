//
//  UserAvatar.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 13/10/24.
//

import SwiftUI

struct UserAvatar: View {
    let initials: String?

    private struct VisualConstants {
        static let avatarSize = 72.0
    }

    var body: some View {
        if let initials = initials {
            Text(initials)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: VisualConstants.avatarSize,
                       height: VisualConstants.avatarSize)
                .background(Color(.systemGray3))
                .clipShape(Circle())
        }
    }
}

#Preview {
    UserAvatar(initials: "PC")
}
