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
            return Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
        case .horizontal:
            return Array(repeating: .init(.fixed(120)), count: 2)
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.reminderCategories, id: \.id) { category in
                switch style {
                case .horizontal:
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: items, pinnedViews: [.sectionHeaders]) {
                            Section(header: categoryHHeader(with: category.header.name)) {
                                ReminderListView(category: category)
                            }
                        }
                        .padding(.vertical)
                    }
                case .vertical:
                    LazyVGrid(columns: items, spacing: 10, pinnedViews: [.sectionHeaders]) {
                        Section(header: categoryVHeader(with: category.header.name)) {
                            ReminderListView(category: category)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }

    private func categoryHHeader(with header: String) -> some View {
        Text(header)
            .bold()
            .rotationEffect(Angle(degrees: -90))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(RoundedRectangle(cornerRadius: 0, style: .continuous)
                            .fill(Color.headerBackground))
    }

    private func categoryVHeader(with header: String) -> some View {
        Text(header)
            .font(.title2)
            .bold()
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 0)
                            .fill(Color.headerBackground))
    }
}
