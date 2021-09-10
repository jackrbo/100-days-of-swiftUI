//
//  ContentView.swift
//  iExpense
//
//  Created by Richard-Bollans, Jack on 3.9.2021.
//

import SwiftUI


struct StyledText: View {
    var title: String
    var amount: Int
    var body: some View {
        
        if amount < 10 {
            Text(title)
                .foregroundColor(.green)
        } else if amount < 100 {
            Text(title)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        } else {
            Text(title)
                .foregroundColor(.red)
        }
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
   
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                StyledText(title: item.name, amount: item.amount)
                                    .font(.headline)
                                StyledText(title: item.type, amount: item.amount)
                                
                            }
                            Spacer()
                            StyledText(title: "\(item.amount)", amount: item.amount)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                EditButton()
            }
            .navigationTitle("Expenses")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showingAddExpense = true
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: self.expenses)
            })
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
