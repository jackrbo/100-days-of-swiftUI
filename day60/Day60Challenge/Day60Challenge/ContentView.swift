//
//  ContentView.swift
//  Day60Challenge
//
//  Created by Richard-Bollans, Jack on 30/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.id) {
                    user in
                    NavigationLink(destination: DetailView(user: user)) {
                        VStack(alignment: .leading) {
                            Text(user.name)
                            Text(user.isActive ? "Status: Active" : "Status: Inactive")
                                .foregroundColor(user.isActive ? Color.green : Color.red)               
                        }
                    }
                    
                }
            }
            .task{
                if users.isEmpty {
                    await loadData()
                }
            }
        }
    }
    
    
    
    func loadData() async {
        print("loading data")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else { print("Invalid URL")
            return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedData = try? decoder.decode([User].self, from: data)  {
                users = decodedData
            } else {
                print("Failed to decoded data")
            }
        } catch {
            print("Invalid data")
        }

        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
