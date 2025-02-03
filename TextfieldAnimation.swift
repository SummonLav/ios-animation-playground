//
//  TextfieldAnimation.swift
//  Playground
//
//  Created by Lavenda Shan on 10/12/24.
//

import SwiftUI

struct TextfieldAnimation: View {
    @State private var password: String = ""
    @State private var isWrongPassword: Bool = false
    @State private var wrongPasswordTrigger: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text("Account Password")
                .font(.caption)
                .foregroundStyle(.gray)
            
            SecureField("Password", text: $password)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .frame(width: 250)
                .phaseAnimator([0, -8, 8, -4, 4, 0], trigger: wrongPasswordTrigger) { content, offset in
                    content
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill((isWrongPassword ? .red.opacity(0.1) : Color.primary.opacity(0.06)).gradient)
                        }
                        .offset(x: offset)
                } animation: { _ in
                        .snappy(duration: 0.13, extraBounce: 0).speed(1.5)
                }
                .onChange(of: password) { oldValue, newValue in
                    isWrongPassword = false
                }
            
            Button {
                // Wrong Password Alert
                isWrongPassword = true
                if isWrongPassword {
                    wrongPasswordTrigger.toggle()
                }
            } label: {
                Text("Login")
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .padding(.top, 15)
        }
    }
}

#Preview {
    TextfieldAnimation()
}
