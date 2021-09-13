//
//  ContentView.swift
//  Moonshot
//
//  Created by Richard-Bollans, Jack on 12.9.2021.
//

import SwiftUI

struct CustomText: View {
    var text: String
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new \(text)")
        self.text = text
    }
}


struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var showingLaunchDates = true

    var body: some View {
        NavigationView {
            if showingLaunchDates {
                List(missions) { mission in
                    NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:44, height: 44)
                        VStack (alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
                .navigationBarTitle("Moonshot")
                .navigationBarItems(leading:
                                        HStack {
                                            Button(action: {showingLaunchDates.toggle()}) {
                                                    Text(showingLaunchDates ? "Show Crew" : "Show Launch Dates")
                                                        .frame(width: 150, alignment: .leading)
                                            }
                                            Spacer()
                                        }
                )
            } else {
                List(astronauts) { astronaut in
                    NavigationLink(destination: AstronautView(astronaut: astronaut)) {
                        Image(astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 83, height: 60)
                            .scaledToFit()
                            .clipShape(Capsule())
                        Text(astronaut.name)
                    }
                }
                .navigationBarTitle("Moonshot")
                .navigationBarItems(leading:
                                        HStack {
                                            Button(action: {showingLaunchDates.toggle()}) {
                                                    Text(showingLaunchDates ? "Show Crew" : "Show Launch Dates")
                                                        .frame(width: 150, alignment: .leading)
                                            }
                                            Spacer()
                                        }
                )
            }
        }
        
    }
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
