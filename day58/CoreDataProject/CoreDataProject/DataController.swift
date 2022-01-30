//
//  DataController.swift
//  CoreDataProject
//
//  Created by Richard-Bollans, Jack on 21/01/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    lazy var container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores() {
            description, error in
            if let error = error  {
                print("Core data failed to load with error: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
    }
}
