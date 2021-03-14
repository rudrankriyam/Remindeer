//
//  ContentView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 11/03/21.
//

import SwiftUI

enum ReminderCategoryHeader: String, CaseIterable {
    case urgent
    case important
    case casual

    var name: String {
        self.rawValue.capitalized
    }
}

enum GridLayoutStyle {
    case vertical
    case horizontal
}

struct ContentView: View {
    @State private var showNewReminderView = false
    @State private var layoutStyle: GridLayoutStyle = .vertical
    @EnvironmentObject var viewModel: RemindersViewModel

    var body: some View {
        NavigationView {
            ReminderView(style: layoutStyle)
                .navigationBarTitle("Remindeer")
                .navigationBarItems(leading: Button(action: {
                    layoutStyle == .vertical ? (layoutStyle = .horizontal) : (layoutStyle = .vertical)
                }, label: {
                    Image(systemName: "rectangle.grid.1x2")
                        .font(.title)
                        .accentColor(.main)
                }), trailing: Button(action: {
                    showNewReminderView.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .accentColor(.main)
                }))
                .sheet(isPresented: $showNewReminderView) {
                    NewReminderView().environmentObject(viewModel)
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ReminderView: View {
    @EnvironmentObject var viewModel: RemindersViewModel

    var style: GridLayoutStyle

    var items: [GridItem] {
        switch style {
        case .vertical:
            return Array(repeating: .init(.flexible()), count: 2)
        case .horizontal:
            return Array(repeating: .init(.fixed(120)), count: 2)
        }
    }

    private func headerView(with header: String) -> some View {
        Text(header)
            // .font(.title2)
            .bold()
            .rotationEffect(Angle(degrees: -90))
            //   .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .fill(Color.headerBackground))
    }

    private func headerVerticalView(with header: String) -> some View {
        Text(header)
            .font(.title2)
            .bold()
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .fill(Color.headerBackground))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.reminderCategories, id: \.id) { category in
                switch style {
                case .horizontal:
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: items, pinnedViews: [.sectionHeaders]) {
                            Section(header: headerView(with: category.header.name)) {
                                remindersView(category: category)
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding(.trailing)

                case .vertical:
                    LazyVGrid(columns: items, spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section(header: headerVerticalView(with: category.header.name)) {
                            remindersView(category: category)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    func remindersView(category: ReminderCategory) -> some View {
        ForEach(category.reminders, id: \.id) { reminder in
            ReminderCardView(category: category, reminder: reminder)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReminderCardView: View {
    var category: ReminderCategory
    var reminder: Reminder
    @EnvironmentObject var viewModel: RemindersViewModel

    var body: some View {
        VStack(spacing: 8) {
            Button(action: {
                withAnimation {
                    viewModel.toggleReminder(for: category, reminder: reminder)
                }
            }, label: {
                ReminderCheckMarkView(markedCompleted: reminder.markedCompleted)
            })
            .frame(alignment: .leading)

            Text(reminder.name).font(.headline)
                .foregroundColor(reminder.markedCompleted ? .white : .main)

            if !reminder.markedCompleted {
                Text("Due: \(getDate())")
                    .font(.subheadline)
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

extension Text {
    func customButton() -> some View {
        self
            .kerning(1)
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .customBackground(color: .main)
    }

    func headlineFont() -> some View {
        self
            .kerning(1)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .top])
            .accessibility(addTraits: .isHeader)
    }

    func bodyFont() -> some View {
        self
            .kerning(1)
            .font(.body)
            .frame(maxWidth: .infinity, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .padding([.horizontal, .top])
    }

    func largeTitleFont() -> some View {
        self
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 32)
            .accessibility(addTraits: .isHeader)
    }
}

extension Color {
    static var main: Color {
        Color(.systemIndigo)
    }

    static var background: Color {
        Color(UIColor { (traits) -> UIColor in
            if traits.userInterfaceStyle == .dark {
                return UIColor.init(red: 50/255, green: 50/255, blue: 54/255, alpha: 1.0)
            } else {
                return UIColor.init(red: 239/255, green: 239/255, blue: 240/255, alpha: 1.0)
            }
        })
    }

    static var headerBackground: Color {
        Color(UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        })
    }
}

extension View {
    func customBackground(color: Color = .background) -> some View {
        self.background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(color))
    }
}

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

struct Reminder: Identifiable, Hashable {
    var id = UUID()
    var name: String = "Reminder Name"
    var date = Date()
    var markedCompleted = false
}

extension Reminder {
    static func testReminders() -> [Reminder] {
        var reminders: [Reminder] = []
        for _ in 0..<10 {
            reminders.append(Reminder())
        }

        return reminders
    }
}

final class RemindersViewModel: ObservableObject {
    @Published var reminderCategories: [ReminderCategory] = ReminderCategory.testReminderCategories()

    func createReminder(for header: ReminderCategoryHeader, reminder: Reminder) {
        if let currentCategory = reminderCategories.firstIndex(
            where: { $0.header == header }) {
            reminderCategories[currentCategory].reminders.append(reminder)
        }
    }

    func toggleReminder(for category: ReminderCategory, reminder: Reminder) {
        if let currentCategory = reminderCategories.firstIndex(
            where: { $0.id == category.id }) {
            if let currentReminder = reminderCategories[currentCategory].reminders.firstIndex(
                where: { $0.id == reminder.id }) {
                reminderCategories[currentCategory].reminders[currentReminder].markedCompleted.toggle()
            }
        }
    }
}

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
