//
//  Text.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

extension Text {
    func headline() -> some View {
        self
            .kerning(1)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .top])
            .accessibility(addTraits: .isHeader)
    }
}
