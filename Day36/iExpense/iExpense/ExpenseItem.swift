//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Richard-Bollans, Jack on 9.9.2021.
//

import Foundation
struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    init () {
        if let data = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let expenses = try? decoder.decode([ExpenseItem].self, from: data) {
                self.items = expenses
                return
            }
            
        }
        
    }
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
}
