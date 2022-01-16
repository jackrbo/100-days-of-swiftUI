//
//  DataController.swift
//  Bookworm
//
//  Created by Richard-Bollans, Jack on 16/01/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores {
            decription, error in
            if let error = error {
                print("Core Data filed to laod: \(error.localizedDescription)")
            }
        }
    }
}
