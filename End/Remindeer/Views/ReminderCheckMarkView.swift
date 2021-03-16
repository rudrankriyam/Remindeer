//
//  ReminderCheckMarkView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

struct ReminderCheckMarkView: View {
    var markedCompleted: Bool

    var accessibilityLabel: Text {
        markedCompleted ? Text("Reminder Completed") : Text("Mark the reminder complete")
    }

    var imageName: String {
        markedCompleted ? "checkmark.circle.fill" : "circle"
    }

    var foregroundColor: Color {
        markedCompleted ? .white : .gray
    }

    var body: some View {
        Image(
            systemName: imageName)
            .font(.system(size: 25))
            .foregroundColor(foregroundColor)
            .accessibility(label: accessibilityLabel)
    }
}
