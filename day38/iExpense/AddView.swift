//
//  AddView.swift
//  iExpense
//
//  Created by Richard-Bollans, Jack on 9.9.2021.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var alertShowing = false
        
    @ObservedObject var expenses: Expenses
    static let types = ["Business", "Personal"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                    
            }
            .navigationBarTitle("Add new expenses")
            .navigationBarItems(trailing:
                                    Button("Save") {
                                        if let actualAmount = Int(self.amount) {
                                            let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                                            self.expenses.items.append(item)
                                            
                                        } else {
                                            alertShowing = true
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }
            )
            .alert(isPresented: $alertShowing) {
                Alert(title: Text("Invalid amount"), message: Text("Please enter an integer value"), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
