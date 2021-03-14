//
//  NewReminderView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

struct NewReminderView: View {
    @State private var category: ReminderCategoryHeader = .casual
    @State private var reminder = Reminder()

    @EnvironmentObject var viewModel: RemindersViewModel
    @Environment(\.presentationMode) private var presentation

    var body: some View {
        NavigationView {
            ScrollView {
                Text("CATEGORIES")
                    .headlineFont()

                Picker("Please choose a category", selection: $category) {
                    ForEach(viewModel.reminderCategories, id: \.self) { category in
                        Text(category.header.name)
                    }
                }

                Text("REMINDER NAME")
                    .headlineFont()

                TextField("REMINDER", text: $reminder.name)
                    .padding()
                    .customBackground()
                    .padding(.horizontal)

                HStack {
                    Text("DUE")
                        .headlineFont()
                        .padding(.bottom)

                    DatePicker(selection: $reminder.date,
                               in: Date()...,
                               displayedComponents: .date
                    ) {
                        Text("Select a date")
                    }
                    .labelsHidden()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding()
                }

                Button(action: {
                    if !reminder.name.isEmpty {
                        viewModel.createReminder(for: self.category, reminder: reminder)
                        presentation.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("CREATE REMINDER")
                        .customButton()
                        .padding()
                })
            }
            .navigationBarTitle("New Reminder")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
