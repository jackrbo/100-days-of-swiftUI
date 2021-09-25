//
//  ContentView.swift
//  ChallengeDay47
//
//  Created by Richard-Bollans, Jack on 22.9.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { activity in
                    NavigationLink(destination: ActivityView(activity: activity)) {
                        Text(activity.name)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Activity")
            .navigationBarItems(trailing:
                                    Button(action: {
                                            showingAddActivity = true
                                       }) {
                                           Image(systemName: "plus")
                                       }
            )
        }
        .sheet(isPresented: $showingAddActivity) {
            AddView(activities: activities)
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
