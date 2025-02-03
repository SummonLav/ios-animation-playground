//
//  NumericText.swift
//  Playground
//
//  Created by Lavenda Shan on 10/12/24.
//

import SwiftUI

struct NumericText: View {
    @State private var showNumber: Bool = false
    
    var body: some View {
        HStack(spacing: 15) {
            Text(showNumber ? "1243 5678 4352 4367" : "xxxx xxxx xxxx xx67")
                .font(.title2)
                .monospaced()
                .fontWeight(.semibold)
                .contentTransition(.numericText())
            
            Button {
                withAnimation(.bouncy) {
                    showNumber.toggle()
                }
            } label: {
                Image(systemName: showNumber ? "eye.slash" : "eye")
                    .foregroundStyle(.purple.gradient)
                    .contentTransition(.symbolEffect(.replace))
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.purple.opacity(0.2).gradient)
        }
    }
}

#Preview {
    NumericText()
}
