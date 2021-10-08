//
//  ContentView.swift
//  newBookworm
//
//  Created by Jack on 8.10.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Book.entity(),
        sortDescriptors: [],
        animation: .default)
    private var books: FetchedResults<Book>
    
    @State var showingAddScreen = false
    

    
    var body: some View {
        NavigationView {
            Text("Count: \(books.count)")
                .navigationBarTitle("BookWorm")
                .navigationBarItems(trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, viewContext)
                }
                
            
        }
            
        
    }

    
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
