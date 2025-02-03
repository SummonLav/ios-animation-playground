//
//  MorphingView.swift
//  Playground
//
//  Created by Lavenda Shan on 10/10/24.
//

import SwiftUI

struct MorphingView: View {
    // MARK: View Properties
    @State var currentImage: CustomShape = .cloud
    @State var pickerImage: CustomShape = .cloud
    @State var turnOffImageMorph: Bool = false
    @State var animateMorph: Bool = false
    @State var blurRadius: CGFloat = 0
    
    var body: some View {
        VStack {
            // MARK: Image Morph
            // Simply mask the canvas shape as image mask
            GeometryReader { proxy in
                let size = proxy.size
                // Background Image
                Image("Mountain-Fall")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -20, y: -30)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    // Turn Off Image Morph
                    .overlay(content: {
                        Rectangle()
                            .fill(Color.white)
                            .opacity(turnOffImageMorph ? 1 : 0)
                    })
                    .mask {
                        // MARK: Morphing shapes with Canvas and Filters
                        Canvas { context, size in
                            // MARK: Morphing Filters
                            context.addFilter(.alphaThreshold(min: 0.5))
                            // MARK: Plays major role in Morphing animation
                            // MARK: For Reverse Animation
                            // Until 20 -> smaller
                            // After 20-40 -> larger
                            context.addFilter(.blur(radius: blurRadius >= 20 ? 20-(blurRadius-20) : blurRadius))
                            
                            // MARK: Draw inside layer
                            context.drawLayer { ctx in
                                if let resolvedImage = context.resolveSymbol(id: 1) {
                                    ctx.draw(resolvedImage, at: CGPoint(x: size.width/2, y: size.height/2), anchor: .center)
                                }
                            }
                        } symbols: {
                            // MARK: Giving Images with ID
                            ResolvedImage(currentImage: $currentImage)
                                .tag(1)
                        }
                        // MARK: Use timeline view for animations
                        .onReceive(Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()) { _ in
                            if animateMorph {
                                if blurRadius <= 40 {
                                    // Animation Speed
                                    blurRadius += 0.5
                                    
                                    if blurRadius.rounded() == 20 {
                                        // MARK: Change of next image
                                        currentImage = pickerImage
                                    }
                                }
                                
                                if blurRadius.rounded() == 40 {
                                    // MARK: End animation and reset blurRadius to zero
                                    animateMorph = false
                                    blurRadius = 0
                                }
                            }
                        }
                    }
            }
            .frame(height: 400)
            
            // MARK: Segmented Picker
            Picker("", selection: $pickerImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) { shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            // MARK: Avoid tap until the current animation is finished
            .overlay(content: {
                Rectangle()
                    .fill(.primary)
                    .opacity(animateMorph ? 0.05 : 0)
            })
            .padding(15.0)
            .padding(.top, -50)
            .onChange(of: pickerImage) { _ in
                animateMorph = true
            }
            
            Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
                .fontWeight(.semibold)
                .padding(.horizontal, 15.0)
                .padding(.vertical, 10.0)
            
//            Slider(value: $blurRadius, in: 0...40)
        }
        .offset(y: -50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 200))
            .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8), value: currentImage)
            .frame(width: 300, height: 300)
    }
}

#Preview {
    Morphing()
}
