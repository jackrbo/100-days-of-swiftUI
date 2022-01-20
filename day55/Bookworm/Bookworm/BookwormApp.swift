//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Richard-Bollans, Jack on 16/01/2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataConrtoller = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataConrtoller.container.viewContext)
        }
    }
}
