//
//  ReminderListView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 16/03/21.
//

import SwiftUI

struct ReminderListView: View {
    var category: ReminderCategory

    var body: some View {
        ForEach(category.reminders, id: \.id) { reminder in
            ReminderCardView(category: category, reminder: reminder)
        }
    }
}

