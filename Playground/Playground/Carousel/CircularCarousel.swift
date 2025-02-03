//
//  ScrollTransition.swift
//  Playground
//
//  Created by Lavenda Shan on 10/11/24.
//

import SwiftUI

struct CircularCarousel: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10.0) {
                    ForEach(images) { image in
                        Image(image.name)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 220, height: size.height)
                            .clipShape(.rect(cornerRadius: 25))
                            .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                content
                                    .blur(radius: phase.isIdentity ? 0 : 2, opaque: false)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.9, anchor: .bottom)
                                    // Circular Carousel
                                    .offset(y: phase.isIdentity ? 0 : 35)
                                    .rotationEffect(.init(degrees: phase.isIdentity ? 0 : phase.value * 15), anchor: .bottom)
                                
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .safeAreaPadding(.horizontal, (size.width - 220) / 2)
        }
        .frame(height: 330)
    }
}

#Preview {
    CircularCarousel()
}

struct ImageModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
}

var images: [ImageModel] = [
    .init(name: "flora-spring"),
    .init(name: "horse-mount"),
    .init(name: "mount-Fall"),
    .init(name: "mount-Fuji"),
    .init(name: "mount-winter"),
    .init(name: "ocean-summer")
    ]
