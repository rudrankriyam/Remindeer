//
//  ContentView.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 11/03/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showNewReminderView = false
    @State private var layoutStyle: GridLayoutStyle = .vertical
    @EnvironmentObject var viewModel: RemindersViewModel

    var body: some View {
        NavigationView {
            ReminderView(style: layoutStyle)
                .navigationTitle("Remindeer")
                .navigationBarItems(
                    leading:
                        AYImageButton(systemName: "rectangle.grid.1x2", label: "Change layout", action: {
                            layoutStyle == .vertical ? (layoutStyle = .horizontal) : (layoutStyle = .vertical)
                        }),
                    trailing:
                        AYImageButton(systemName: "plus", label: "Add reminder", action: {
                            showNewReminderView.toggle()
                        }))
                .sheet(isPresented: $showNewReminderView) {
                    NewReminderView().environmentObject(viewModel)
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
