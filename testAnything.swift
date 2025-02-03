//
//  testAnything.swift
//  Playground
//
//  Created by Lavenda Shan on 12/26/24.
//

import SwiftUI

struct testAnything: View {
    var body: some View {
            VStack(spacing: 0) {
                Color.green
                Color.green
                Color.green
                Color.yellow
                Color.orange
                Color.red
                Color.purple
                Color.blue
            }
            .mask(
                Image(systemName: "applelogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            )
            .frame(width: 128, height: 128)
        }
    }

#Preview {
    testAnything()
}
