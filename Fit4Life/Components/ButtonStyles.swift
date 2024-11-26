//
//  ButtonStyles.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/17/24.
//

import SwiftUI

// Custom Button Modifier
struct CustomButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
            .background(Color("ButtonColor"))
            .foregroundColor(.white)
            .cornerRadius(100)
            .frame(height: 60)
    }
}

// Extension on View to apply the button modifier
extension View {
    func customButtonStyle() -> some View {
        self.modifier(CustomButtonModifier())
    }
}
