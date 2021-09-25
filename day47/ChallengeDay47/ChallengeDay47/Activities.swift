//
//  Activities.swift
//  ChallengeDay47
//
//  Created by Richard-Bollans, Jack on 22.9.2021.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [Activity]()
}

class Activity: Identifiable{
    public init(name: String, desc: String, numberOfCompletions: Int) {
        self.name = name
        self.numberOfCompletions = numberOfCompletions
        self.desc = desc
    }
    
    let id = UUID()
    @Published var name: String = ""
    @Published var desc: String = ""
    @Published  var numberOfCompletions = 0
}
