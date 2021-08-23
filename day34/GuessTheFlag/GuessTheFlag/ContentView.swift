//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jack on 16.7.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var angle: Double = 0
    @State private var scale : CGFloat = 1
    @State private var wrongTapped = false
    @State private var rightTapped = false
    @State private var flagTapped = -1
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
            
            VStack(spacing: 30) {
                
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.title)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        flagTapped = number
                    }) {
                    Image(self.countries[number])
                        .renderingMode(.original)
                        
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 3))
                        .shadow(color: .black, radius: 2)
                        .scaleEffect(number == correctAnswer && wrongTapped ? 1.1 : 1)
                        .animation( .easeIn(duration: 0.5))
                        .opacity(number != correctAnswer && rightTapped ? 0.25: 1)
                        .scaleEffect(flagTapped == number && wrongTapped ? 0.8 : 1)
                        .animation(.easeIn(duration: 1))
                        .rotation3DEffect(
                            Angle(degrees: number == correctAnswer ? angle: 0),
                            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                        )
                        
                        

                        
                    }
                }
                Label(
                    title: { Text("Your score is \(score)") },
                    icon: { }
                )
                .foregroundColor(.white)
               
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                        self.askQuestion()
                        self.wrongTapped = false
                        self.rightTapped = false
                    self.flagTapped = -1
                    }
                )
            }
            
        }
    }
    func placeHolder() {}
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation(.easeIn){
                angle += 360
            }
            rightTapped = true
        } else {
            scoreTitle = "Wrong\nThat's the flag of \(countries[number])"
            score -= 1
            scale = 1.5
            wrongTapped = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showingScore = true
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
