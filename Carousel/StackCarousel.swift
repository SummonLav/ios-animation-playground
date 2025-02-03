//
//  StackCarousel.swift
//  Playground
//
//  Created by Lavenda Shan on 10/11/24.
//

import SwiftUI

struct StackCarousel: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12.0) {
                    ForEach(images) { image in
                        let index = Double(images.firstIndex(where: { $0.id == image.id}) ?? 0)
                        
                        GeometryReader {
                            let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                            
                            Image(image.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 220, height: size.height)
                                .clipShape(.rect(cornerRadius: 25.0))
                                .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                    content
                                        .blur(radius: phase.isIdentity ? 0 : 2, opaque: false)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.9, anchor: .bottom)
                                        .offset(y: phase.isIdentity ? 0 : -10)
                                        .rotationEffect(.init(degrees: phase.isIdentity ? 0: phase.value * 5), anchor: .bottomTrailing)
                                        .offset(x: minX < 0 ? minX / 2 : -minX)
                                }
                        }
                        .frame(width: 220)
                        .zIndex(-index)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .safeAreaPadding(.horizontal, (size.width - 220) / 2)
        }
    }
}

#Preview {
    StackCarousel()
}
