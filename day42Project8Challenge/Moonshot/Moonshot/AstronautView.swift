//
//  AstronautView.swift
//  Moonshot
//
//  Created by Richard-Bollans, Jack on 13.9.2021.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut){
        
        let missions: [Mission] = Bundle.main.decode("missions.json")
        self.astronaut = astronaut
        var matches = [Mission]()
        
        for mission in missions {
            if let _ = mission.crew.first(where: {$0.name == astronaut.id}) {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions")
                    ForEach(self.missions, id: \.id) { mission in
                        Text(mission.displayName)
                    }
                }
                
                
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        
        AstronautView(astronaut: astronauts[0])
    }
}
