//
//  ReminderCategory.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import Foundation

struct ReminderCategory: Identifiable, Hashable {
    var id = UUID()
    var header: ReminderCategoryHeader = .casual
    var reminders: [Reminder] = []
}

extension ReminderCategory {
    static func testReminderCategories() -> [ReminderCategory] {
        var reminderCategories: [ReminderCategory] = []
        
        for header in ReminderCategoryHeader.allCases {
            reminderCategories.append(ReminderCategory(header: header, reminders: Reminder.testReminders()))
        }

        return reminderCategories
    }
}
