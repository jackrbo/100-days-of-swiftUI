//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Richard-Bollans, Jack on 21.10.2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
