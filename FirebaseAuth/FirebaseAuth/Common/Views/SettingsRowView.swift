//
//  SettingsRowView.swift
//  FirebaseAuth
//
//  Created by Pablo Caraballo Gómez on 16/1/24.
//

import SwiftUI

struct SettingsRowView: View {
    let imageSystemName: Constants.ImageSystemName
    let title: String
    let tintColor: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(imageSystemName: imageSystemName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)

            Text(title)
                .font(.subheadline)
                .foregroundColor(Resources.Colors.Common.textPrimary)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(imageSystemName: .gear,
                        title: Resources.Strings.Profile.version,
                        tintColor: Color(.systemGray))
    }
}
