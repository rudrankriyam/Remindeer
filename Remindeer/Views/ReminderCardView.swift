//
//  ReminderCardView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

struct ReminderCardView: View {
    var category: ReminderCategory
    var reminder: Reminder
    @EnvironmentObject var viewModel: RemindersViewModel

    var body: some View {
        VStack(spacing: 8) {
            Button(action: {
                withAnimation {
                    viewModel.toggleReminder(for: category.header, reminder: reminder)
                }
            }) {
                ReminderCheckMarkView(markedCompleted: reminder.markedCompleted)
            }
            .frame(alignment: .leading)

            Text(reminder.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(reminder.markedCompleted ? .white : .main)

            if !reminder.markedCompleted {
                Text("Due: \(getDate())").font(.subheadline)
            }
        }
        .accessibilityElement(children: .combine)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .customBackground(color: reminder.markedCompleted ? .main : .background)
    }

    private func getDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "MMM, dd"
        return format.string(from: reminder.date)
    }
}
