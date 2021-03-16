//
//  View.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

extension View {
    func customBackground(color: Color = .background) -> some View {
        self.background(RoundedRectangle(cornerRadius: 8).fill(color))
    }
}
