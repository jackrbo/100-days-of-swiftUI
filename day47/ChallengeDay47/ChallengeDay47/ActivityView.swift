//
//  SwiftUIView.swift
//  ChallengeDay47
//
//  Created by Richard-Bollans, Jack on 23.9.2021.
//

import SwiftUI

struct ActivityView: View {
    
    
    var activity: Activity
    @State private var additionalCompletions = 0
    @State private var showingAlert = false
    
    private var totalCompletions: Int {
        if activity.numberOfCompletions + additionalCompletions < 0 {
            return 0
        }
        return activity.numberOfCompletions + additionalCompletions
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Form{
                    Section(header: Text("Description:")) {
                        Text(activity.desc)
                    }
                    Section(header: Text("Sessions done:")){
                        Text("\(totalCompletions)")
                    }
                    
                }
                    
                
                    HStack {
                        Spacer()
                        Button(action: {
                            if activity.numberOfCompletions + additionalCompletions == 0 {
                                return
                            }
                            additionalCompletions -= 1
                            
                        }) {
                            Image(systemName: "minus")
                                .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.primary)
                                .clipShape(Capsule())
                        }
                        .padding(.all)
                        
                        Spacer()
                        Button(action: {
                                additionalCompletions += 1
                        }) {
                            Image(systemName: "plus")
                                .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.primary)
                                .clipShape(Capsule())
                                
                        }
                        .padding(.all)
                        
                        Spacer()
                    }
                 
                
                
                    
                
            }
            .navigationTitle(Text(activity.name))
        }
        .onDisappear(perform: {
            saveActivity()
        })
        
    }
    
    func saveActivity() {
        activity.numberOfCompletions = activity.numberOfCompletions + additionalCompletions
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(name: "my Activity", desc: "This is a new activity. with a very long description.\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\nokokokokokokokokoko\n", numberOfCompletions: 0)
        ActivityView(activity: activity)
    }
}
