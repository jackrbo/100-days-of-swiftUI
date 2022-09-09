//
//  DataController.swift
//  Day60Challenge
//
//  Created by Richard-Bollans, Jack on 02/02/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Day61CoreData")
    
    init() {
        container.loadPersistentStores() {
            description, error in
            if let error = error  {
                print("Core data failed to load with error: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}
