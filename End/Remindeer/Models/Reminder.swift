//
//  Reminder.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import Foundation

struct Reminder: Identifiable, Hashable {
    var id = UUID()
    var name = defaultReminderName
    var date = Date()
    var markedCompleted = false
}

extension Reminder {
    static func testReminders() -> [Reminder] {
        var reminders: [Reminder] = []

        for _ in 0..<12 {
            reminders.append(Reminder())
        }

        return reminders
    }
}

extension Reminder {
    static let defaultReminderName = "Reminder Name"
}
