//
//  DotGridView.swift
//  Playground
//
//  Created by Lavenda Shan on 12/26/24.
//

import SwiftUI

struct DotGridView: View {
    
    @State private var selectedView: Int = 1
    private let position: CGFloat = 13.0
    // Select Diagonal Circle(s)
    private let listArray = [1, 2, 3, 4, 2, 3, 4, 5, 3, 4, 5, 6, 4, 5, 6, 7]
    private let columns = [
        GridItem(.flexible(minimum: 50)),
        GridItem(.flexible(minimum: 50)),
        GridItem(.flexible(minimum: 50)),
        GridItem(.flexible(minimum: 50))
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                
                Spacer(minLength: 200)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(listArray.indices, id: \.self) { index in
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.blue)
                            .overlay {
                                GeometryReader { geometry in
                                    let localFrame = geometry.frame(in: .local)
                                    
                                    Circle()
                                        .strokeBorder(Color.blue, lineWidth: 3.0)
                                        .background(Circle().foregroundStyle(Color.white))
                                        .position(x: selectedView == listArray[index] ? position : localFrame.midX, y: selectedView == listArray[index] ? position : localFrame.midY)
                                }
                            }
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                withAnimation(.smooth) {
                    if selectedView == 7 {
                        selectedView = 0
                    }
                    selectedView += 1
                }
            }
        }
    }
}

#Preview {
    DotGridView()
}
