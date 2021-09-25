//
//  SwiftUIView.swift
//  ChallengeDay47
//
//  Created by Richard-Bollans, Jack on 24.9.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var numberOfCompletions = ""
    @State private var description = ""
    @State private var isAlerting = false
    @ObservedObject var activities: Activities

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Please enter the name of the activity")){
                    TextField("Name", text: $name)
                }
                Section(header: Text("Please describe the activity")){
                    TextField("Description", text: $description)
                }
                Section(header: Text("Please enter the number of sessions you have completed")){
                    TextField("Number of sessions", text: $numberOfCompletions)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                if let completions = Int(numberOfCompletions) {
                    let item = Activity(name: self.name, desc: description, numberOfCompletions: completions)
                    self.activities.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else if numberOfCompletions == "" {
                    let item = Activity(name: self.name, desc: description, numberOfCompletions: 0)
                    self.activities.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    isAlerting = true
                }
                
            })
            .alert(isPresented: $isAlerting, content: {
                Alert(title: Text("Incorrect amount"), message: Text("Please enter a whole number, or leave blank"), dismissButton: .none)
            })
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        let data = encoder.encode(activities)
        
    }
    
}



struct AddView_Previews: PreviewProvider {
   
    static var previews: some View {
        let activities = Activities()
        AddView(activities: activities)
    }
}
