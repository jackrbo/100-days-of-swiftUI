//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Richard-Bollans, Jack on 21/01/2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
