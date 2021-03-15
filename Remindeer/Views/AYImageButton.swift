//
//  AYImageButton.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

struct AYImageButton: View {
    private var systemName: String
    private var label: String

    private var action: () -> ()

    /// Creates a labeled system symbol image that you can use as
    /// content for controls, with the specified label for accessibility.
    ///
    /// - Parameters:
    ///   - systemName: The name of the system symbol image.
    ///   - label: The label associated with the image used for accessibility.
    public init(systemName: String, label: String, action: @escaping () -> ()) {
        self.systemName = systemName
        self.label = label
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Group {
                if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
                    Image(systemName: systemName)
                        .accessibilityLabel(Text(label))
                } else {
                    Image(systemName: systemName)
                        .accessibility(label: Text(label))
                }
            }
            .font(.title)
            .accentColor(.main)
        }
    }
}
