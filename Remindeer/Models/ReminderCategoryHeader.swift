//
//  ReminderCategoryHeader.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import Foundation

enum ReminderCategoryHeader: String, CaseIterable {
    case urgent
    case important
    case casual

    var name: String {
        self.rawValue.capitalized
    }
}
