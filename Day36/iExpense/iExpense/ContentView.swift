//
//  ContentView.swift
//  iExpense
//
//  Created by Richard-Bollans, Jack on 3.9.2021.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
   
    
        
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("\(item.amount)")
                    }
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Expenses")
            
            .navigationBarItems(trailing:
                                    Button(action: {
//                                        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                                        expenses.items.append(expense)
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
    
    func save() {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
