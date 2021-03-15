//
//  ButtonStyle.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 15/03/21.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .customBackground(color: .main)
            .padding()
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
