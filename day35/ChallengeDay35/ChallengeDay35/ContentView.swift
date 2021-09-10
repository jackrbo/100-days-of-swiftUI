//
//  ContentView.swift
//  ChallengeDay35
//
//  Created by Richard-Bollans, Jack on 23.8.2021.
//

import SwiftUI

enum AmountOfQuestions: String, CaseIterable {
    case five, ten, twenty, all
}

struct ContentView: View {
    @State private var isActive = false
    @State private var timesTable = 0
    @State private var numberOfQuestions = 1
    
    @State private var answer = ""
    @State private var questionNumber = 1
    
    var body: some View {
        NavigationView {
            if !isActive {
                Group {
                    VStack {
                        Form {
                            Section(header: Text("Quiz me on multiplactions up to:")){
                                Stepper("\(timesTable)", value: $timesTable, in: 0...12)
                            }
                            Section(header: Text("How many questions do you want?")) {
                                Picker("How many questions do you want?", selection: $numberOfQuestions) {
                                    ForEach(0..<4){
                                        Text(AmountOfQuestions.allCases[$0].rawValue)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        Spacer()
                        Button("Start") {
                            isActive = true
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle("I times")
            } else {
                Group {
                    VStack {
                        Text("Question \(questionNumber)")
                        TextField("Please enter your answer", text: $answer)
                            .keyboardType(.numberPad)
                    }
                }
            }
            
        }
        
//        .navigationBarItems(leading: <#T##View#>)
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
