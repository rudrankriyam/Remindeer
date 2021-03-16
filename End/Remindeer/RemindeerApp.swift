//
//  RemindeerApp.swift
//  Remindeer
//
//  Created by Rudrank Riyam on 11/03/21.
//

import SwiftUI

@main
struct RemindeerApp: App {
    @StateObject private var viewModel = RemindersViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
