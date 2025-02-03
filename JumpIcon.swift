//
//  Icon-Wiggle.swift
//  Playground
//
//  Created by Lavenda Shan on 10/12/24.
//

import SwiftUI

struct JumpIcon: View {
    @State private var WiggleTrigger: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("My Journal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .foregroundStyle(.red.gradient)
                    }
                    .keyframeAnimator(initialValue: Jump(), trigger: WiggleTrigger) { content, value in
                        content
                            .rotationEffect(.init(degrees: value.rotation), anchor: .bottom)
                            .scaleEffect(y: value.scaleY, anchor: .bottom)
                            .offset(y: value.offsetY)
                    } keyframes: { _ in
                        KeyframeTrack(\.scaleY) {
                            // Total Duration: 1.0
                            SpringKeyframe(0.4, duration: 0.2, spring: .bouncy)
                            CubicKeyframe(1.15, duration: 0.1)
                            CubicKeyframe(1.15, duration: 0.5)
                            CubicKeyframe(1, duration: 0.2)
                        }
                        KeyframeTrack(\.offsetY) {
                            SpringKeyframe(15, duration: 0.2, spring: .smooth)
                            SpringKeyframe(-12, duration: 0.6, spring: .smooth)
                            SpringKeyframe(0, duration: 0.2, spring: .smooth)
                        }
                        KeyframeTrack(\.rotation) {
                            CubicKeyframe(0, duration: 0.4)
                            CubicKeyframe(14, duration: 0.1)
                            CubicKeyframe(-14, duration: 0.1)
                            CubicKeyframe(0, duration: 0.1)
                        }
                    }
                }
            }
            .onTapGesture {
                WiggleTrigger.toggle()
            }
        }
    }
    struct Jump {
        var scaleY: CGFloat = 1
        var offsetY: CGFloat = 0
        var rotation: CGFloat = 0
    }
}

#Preview {
    JumpIcon()
}
