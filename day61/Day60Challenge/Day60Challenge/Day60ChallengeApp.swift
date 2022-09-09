//
//  Day60ChallengeApp.swift
//  Day60Challenge
//
//  Created by Richard-Bollans, Jack on 30/01/2022.
//

import SwiftUI


@main
struct Day60ChallengeApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
