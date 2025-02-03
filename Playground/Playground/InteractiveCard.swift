//
//  InteractiveCard.swift
//  Playground
//
//  Created by Lavenda Shan on 11/24/24.
//

import SwiftUI

struct InteractiveCard: View {
    @State var dragOffset: CGSize = .zero
    @State var isDragging: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(LinearGradient(gradient: .init(colors: [.red, .orange, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 300, height: 200)
                .shadow(radius: 15.0)
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.black.gradient)
                    .frame(width: 300, height: 200)
                
                Text("🔥 Interactive Card").font(.title)
            }
            .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.gray.opacity(0.3), lineWidth: 2))
            .rotation3DEffect(.init(degrees: Double(dragOffset.width) / 10), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.init(degrees: Double(dragOffset.height) / -10), axis: (x: 1, y: 0, z: 0))
        }
        .gesture(DragGesture().onChanged { value in
            isDragging = true
            dragOffset = value.translation
        }
            .onEnded { _ in
                isDragging = false
                withAnimation(.spring) { dragOffset = .zero }
            })
        .animation(isDragging ? .none : .spring, value: dragOffset)
    }
    
}


#Preview {
    InteractiveCard()
}
