//
//  ContentView.swift
//  Day25
//
//  Created by Richard-Bollans, Jack on 19.8.2021.
//


import SwiftUI

struct ContentView: View {
    var hands = ["Rock", "Paper", "Scissors"]
    @State private var appHand = Int.random(in: 0...2)
    @State private var shouldWin =  Bool.random()
    
    
    @State private var playerChoice = 1
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameNumber = 0
    
    var body: some View{
        Form {
            
            Section(header:Text("Game:")) {
                Text("\(gameNumber)")
            }
            
            Section(header:Text("Your score is:")) {
                Text("\(score)")
            }
            
            Section(header:Text("I play:")) {
                Text(hands[self.appHand])
            }
                
            Section(header:Text(shouldWin ? "Play to Win" : "Play to Lose")) {
                
                ForEach(0 ..< hands.count) { number in
                    Button( action: {
                        print("tapped \(number)")
                        print(appHand)
                        handTapped(number)
                    }) {
                        Text(self.hands[number])
                    }
                }
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Final score"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Replay")){
                    replayGame()
                })
        }
    }
    
    func handTapped(_ tapped: Int){
        if shouldWin {
            if (tapped + 2) % 3 == appHand {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
                score -= 1
            }
        } else {
            if (appHand + 2) % 3  == tapped {
                scoreTitle = "Correct"
                score += 1
            } else {
                scoreTitle = "Wrong"
                score -= 1
            }
        }
        updateGame()
    }
    
    func updateGame() {
        
        gameNumber += 1
        appHand = Int.random(in: 0...2)
        shouldWin =  Bool.random()
        
        if gameNumber == 10 {
            showingScore = true
        }
    }
    func replayGame() {
        gameNumber = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

