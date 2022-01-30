//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Richard-Bollans, Jack on 29/01/2022.
//

import SwiftUI

struct FilteredList: View {
    @FetchRequest private var fetchRequest: FetchedResults<Singer>
    init(filterOn: String, predicate: Predicate, filter: String, sortDescriptors: [NSSortDescriptor] = []) {
        _fetchRequest = FetchRequest(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "\(filterOn) \(predicate.rawValue) %@" ,filter))
        print("\(filterOn) \(predicate.rawValue) %@" ,filter)
    }
    var body: some View {
        List {
            ForEach(fetchRequest, id: \.self) {
                singer in
                let firstName = singer.firstName ?? "Unknown first name"
                let lastName = singer.lastName ?? "Unknown last name"
                Text("Showing \(firstName) \(lastName)")
            }
        }
    }
}

enum Predicate: String {
    case beginsWith = "BEGINSWITH[C]"
    case contains = "CONTAINS"
}
