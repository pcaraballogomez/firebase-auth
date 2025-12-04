//
//  LoadingDotsView.swift
//  FirebaseAuth-foo
//
//  Created by Pablo Caraballo Gómez on 4/12/25.
//

import SwiftUI

struct LoadingDotsView: View {
    @State private var dotCount = 3

    var body: some View {
        HStack(spacing: 0) {
            Text(Resources.Strings.Common.loading)
                .font(.headline)
                .foregroundColor(.gray)
            Text(String(repeating: ".", count: dotCount))
                .font(.headline)
                .foregroundColor(.gray)
                .frame(width: 30, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                dotCount = (dotCount + 1) % 4
            }
        }
    }
}

#Preview {
    LoadingDotsView()
}
