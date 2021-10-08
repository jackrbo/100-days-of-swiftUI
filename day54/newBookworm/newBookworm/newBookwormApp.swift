//
//  newBookwormApp.swift
//  newBookworm
//
//  Created by Jack on 8.10.2021.
//

import SwiftUI

@main
struct newBookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
