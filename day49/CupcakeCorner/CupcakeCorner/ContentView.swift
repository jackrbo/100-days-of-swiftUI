//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Richard-Bollans, Jack on 27.9.2021.
//

import SwiftUI

struct ContentView: View {
//    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }
//        .onAppear(perform: loadData)
        
        Form {
           Section {
               TextField("Username", text: $username)
               TextField("Email", text: $email)
           }

           Section {
               Button("Create account") {
                   print("Creating account…")
               }
           }
//           .disabled(username.isEmpty || email.isEmpty)
           .disabled(disableForm)
       }
        
    }
    
    
    
//    func loadData() {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=blood+wizards&entity=song")
//        else {
//            print("Invalid url")
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let data = data {
//                let decoder = JSONDecoder()
//                guard let responses = try? decoder.decode(Response.self, from: data)
//                else {
//                    return
//                }
//                DispatchQueue.main.async(execute: {
//                    results = responses.results
//                })
//                return
//            }
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//        }.resume()
//    }
        
        
    
}



class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
