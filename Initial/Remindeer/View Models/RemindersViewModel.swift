//
//  RemindersViewModel.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import Foundation

final class RemindersViewModel: ObservableObject {
    @Published var reminderCategories: [ReminderCategory] = ReminderCategory.testReminderCategories()

    func createReminder(for header: ReminderCategoryHeader, reminder: Reminder) {
        if let currentCategory = reminderCategories.firstIndex(where: { $0.header == header }) {
            reminderCategories[currentCategory].reminders.append(reminder)
        } else {
            reminderCategories.append(ReminderCategory(header: header, reminders: [reminder]))
        }
    }

    func toggleReminder(for header: ReminderCategoryHeader, reminder: Reminder) {
        if let currentCategory = reminderCategories.firstIndex(where: { $0.header == header }) {
            if let currentReminder = reminderCategories[currentCategory].reminders.firstIndex(
                where: { $0.id == reminder.id }) {
                reminderCategories[currentCategory].reminders[currentReminder].markedCompleted.toggle()
            }
        }
    }
}
