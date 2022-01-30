//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Richard-Bollans, Jack on 21/01/2022.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct wizardContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry"
            }
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}

struct RelationshipContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) {
                    country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self){ candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.fullName = "United Kingdom"
                candy1.origin?.shortName = "UK"
                
                let candy2 = Candy(context: moc)
                candy2.name = "Twix"
                candy2.origin = Country(context: moc)
                candy2.origin?.fullName = "United Kingdoms"
                candy2.origin?.shortName = "UK"
                
                let candy3 = Candy(context: moc)
                candy3.name = "KitKat"
                candy3.origin = Country(context: moc)
                candy3.origin?.fullName = "United Kingdom"
                candy3.origin?.shortName = "UK"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.fullName = "Switzerland"
                candy4.origin?.shortName = "CH"
                
                try? moc.save()
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var filter = "S"
    @State var property = "lastName"
    @State var predicate = Predicate.contains
    
    var body: some View {
        VStack {
            FilteredList(filterOn: property, predicate: predicate, filter: filter, sortDescriptors: [NSSortDescriptor(key: "firstName", ascending: false)])
            
            Text("Filtering on \(property) with \(filter) and predicate \(predicate.rawValue)")
            Button("Filter on last name") {
                property = "lastName"
            }
            Button("Filter on first name") {
                property = "firstName"
            }
            Button("S") {
                filter = "S"
            }
            Button("T") {
                filter = "T"
            }
            Button("J") {
                filter = "J"
            }
            Button("M") {
                filter = "m"
            }
            Button("Add") {
                let singer1 = Singer(context: moc)
                singer1.firstName = "Taylor"

                singer1.lastName = "Swift"

                let singer2 = Singer(context: moc)
                singer2.firstName = "Sweet James"

                singer2.lastName = "Taylor"
                
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
