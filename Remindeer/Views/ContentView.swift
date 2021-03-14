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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
