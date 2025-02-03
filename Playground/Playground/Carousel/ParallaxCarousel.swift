//
//  ParallaxCarousel.swift
//  Playground
//
//  Created by Lavenda Shan on 10/11/24.
//

import SwiftUI

struct ParallaxCarousel: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20.0) {
                    ForEach(images) { image in
                        Image(image.name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300)
                            .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                content
                                    .offset(x: phase.isIdentity ? 0 : -phase.value * 80)
                            }
                            .frame(width: 400, height: size.height)
                            .clipShape(.rect(cornerRadius: 25))
                    }
                }
                .scrollTargetLayout()
            }
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .safeAreaPadding(.horizontal, (size.width - 220) / 2)
        }
        .frame(height: 600)
    }
}

#Preview {
    ParallaxCarousel()
}
