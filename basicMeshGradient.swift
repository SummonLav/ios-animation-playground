//
//  basicMeshGradient.swift
//  Playground
//
//  Created by Lavenda Shan on 9/1/24.
//

import SwiftUI

struct basicMeshGradient: View {
    
    @State var bgColor: Color = .black
    
    var body: some View {
        ZStack {
            //bgColor.ignoresSafeArea()
            
            if #available(iOS 18.0, *) {
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: [
                        .init(0, 0), .init(0.5, 0), .init(1, 0),
                        .init(0, 0.5), .init(1, 0.5), .init(1, 0.5),
                        .init(0, 1), .init(0.5, 1), .init(1, 1)
                    ],
                    colors: [
                        .red, .purple, .indigo,
                        .red, .purple, .indigo,
                        .red, .purple, .indigo
//                        .orange, .cyan, .blue,
//                        .yellow, .green, .mint
                    ]
                )
            } else {
                // Fallback on earlier versions
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    basicMeshGradient()
}
