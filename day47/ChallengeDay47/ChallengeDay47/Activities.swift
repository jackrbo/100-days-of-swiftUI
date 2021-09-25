//
//  Activities.swift
//  ChallengeDay47
//
//  Created by Richard-Bollans, Jack on 22.9.2021.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items) {
                UserDefaults.standard.set(data, forKey: "Activities")
            }
        }
    }
    
    init () {
        if let data = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            
            if let activities = try? decoder.decode([Activity].self, from: data) {
                self.items = activities
                return
            }
            
        }
        
    }
}

struct Activity: Identifiable, Codable {
    let id = UUID()
    var name: String = ""
    var desc: String = ""
    var numberOfCompletions = 0
}
