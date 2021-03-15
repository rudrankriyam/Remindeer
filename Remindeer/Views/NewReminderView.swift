//
//  NewReminderView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

struct NewReminderView: View {
    @State private var header: ReminderCategoryHeader = .casual
    @State private var reminder = Reminder()

    @EnvironmentObject var viewModel: RemindersViewModel
    @Environment(\.presentationMode) private var presentation

    var body: some View {
        NavigationView {
            ScrollView {
                Text("CATEGORIES").headline()

                Picker("Please choose a category", selection: $header) {
                    ForEach(ReminderCategoryHeader.allCases, id: \.self) { header in
                        Text(header.name)
                    }
                }

                Text("REMINDER NAME").headline()
                
                TextField("REMINDER", text: $reminder.name)
                    .padding()
                    .customBackground()
                    .padding(.horizontal)

                HStack {
                    Text("DUE").headline()

                    DatePicker(selection: $reminder.date, in: Date()..., displayedComponents: .date) {
                        Text("Select a date")
                    }
                    .labelsHidden()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding()
                }

                Button(action: {
                    viewModel.createReminder(for: header, reminder: reminder)
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("CREATE REMINDER")
                        .kerning(1.0)
                })
                .disabled(!reminderButtonStatus)
                .buttonStyle(CustomButtonStyle(status: reminderButtonStatus))
            }
            .navigationTitle("New Reminder")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var reminderButtonStatus: Bool {
        !reminder.name.isEmpty && reminder.name != Reminder.defaultReminderName
    }
}
