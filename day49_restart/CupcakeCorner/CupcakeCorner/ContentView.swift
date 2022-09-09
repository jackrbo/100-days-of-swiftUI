//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Richard-Bollans, Jack on 9.9.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    var body: some View {
        // MARK: - Forms
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
            .disabled(username.count < 5 || email.isEmpty)

        }

       
               
           
        // MARK: - loading data from url
//        List(results, id: \.trackId) {
//            item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }
//        .task {
//            await loadData()
//        }
        
        // MARK: - async images
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView("Hmm")
//        }
//        .frame(width: 200, height: 200)
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("noped")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(Response.self, from: data) else {
                return
            }
            results = response.results
        } catch {
            print("Invalid data")
        }
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
        case age
    }
    @Published var name = "Paul Hudson"
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
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
