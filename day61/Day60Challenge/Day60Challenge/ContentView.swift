//
//  ContentView.swift
//  Day60Challenge
//
//  Created by Richard-Bollans, Jack on 30/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
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
                    await MainActor.run {
                        createCachedUsers()
                    }
                }
            }
        }
    }
    
    func createCachedUsers() {
        for user in users {
            let cachedUser = CachedUser(context: moc)
            cachedUser.name = user.name
            cachedUser.age = user.age
            cachedUser.isActive = user.isActive
            cachedUser.id = user.id
            cachedUser.company = user.company
            cachedUser.tags = user.tags.joined(separator: ",")
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        try? moc.save()
    }
    
    
    func loadData() async {
        print("loading data")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else { print("Invalid URL")
            return }
        do {
            URLSession.shared.configuration.urlCache?.removeAllCachedResponses() // to test what happens if usrr goes offline and no caching/after cach has been removed
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedData = try? decoder.decode([User].self, from: data)  {
                users = decodedData
            } else {
                print("Failed to decoded data")
            }
        } catch {
            loadFromCoreData()
        }
    }
    
    func loadFromCoreData() {
        for cachedUser in cachedUsers{
            let user = User(id: cachedUser.wrappedId, isActive: cachedUser.isActive, name: cachedUser.wrappedName, age: cachedUser.age, company: cachedUser.wrappedCompany, email: cachedUser.wrappedEmail, address: cachedUser.wrappedAddress, about: cachedUser.wrappedAbout, registered: cachedUser.wrappedRegistered, tags: cachedUser.wrappedTags.components(separatedBy: ","), friends: cachedUser.friendsArray)
            users.append(user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
