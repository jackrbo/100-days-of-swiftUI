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

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    

    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) {
                    country in
                    Section (header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray) {
                            candy in
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
                candy2.origin?.fullName = "United Kingdom"
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
                
                try? self.moc.save()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
