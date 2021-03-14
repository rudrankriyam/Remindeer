//
//  ReminderView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 14/03/21.
//

import SwiftUI

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

    private func remindersView(category: ReminderCategory) -> some View {
        ForEach(category.reminders, id: \.id) { reminder in
            ReminderCardView(category: category, reminder: reminder)
        }
    }
}
