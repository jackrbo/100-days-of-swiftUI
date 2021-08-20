//
//  ContentView.swift
//  WordScramble
//
//  Created by Richard-Bollans, Jack on 20.8.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var scores = 0
    
    var score: Int {
        var score = 0
        for word in usedWords {
            switch word.count {
            case 3:
                score += 1
            case 4:
                score += 2
            case 5:
                score += 4
            case 6:
                score += 5
            case 7:
                score += 7
            case 8:
                score += 9
            default:
                score += 0
            }
        }
        return score
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                .autocapitalization(.none)
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text("\($0)")
                }
                Text("Current score: \(scores)")
            }
            .navigationBarTitle(Text(rootWord))
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
            .navigationBarItems(leading: Button(action: startGame) {
                Text("New game")
                    .bold()
                    .font(.largeTitle)
            })
        }
        .onAppear(perform: startGame)
        
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Not original", message: "You have already used this word")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Not possible", message: "You can only use each letter from \(rootWord) once")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "\(answer) is not a word", message: "Please enter only real english words")
            return
        }
        guard isLongEnough(word: answer) else {
            wordError(title: "\(answer) is too short", message: "Please enter a word longer than 2 letters")
            return
        }
        guard isNotRoot(wird: answer) else {
            wordError(title: "Don't use \(rootWord)", message: "Please enter a new word")
            return
        }
        usedWords.insert(answer, at: 0)
        switch answer.count {
        case 3:
            scores += 1
        case 4:
            scores += 2
        case 5:
            scores += 4
        case 6:
            scores += 5
        case 7:
            scores += 7
        case 8:
            scores += 9
        default:
            scores += 0
        }
        newWord = ""
    }
    
    func startGame() {
        usedWords = [String]()
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWordsString = try? String(contentsOf: startWordsUrl) {
                let startWords = startWordsString.components(separatedBy: "\n")
                rootWord = startWords.randomElement() ?? "Silkworm"
                return
            }
        }
        rootWord = "hello"
    }
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let index = tempWord.firstIndex(of: letter) {
                    tempWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isLongEnough(word: String) -> Bool {
        return word.count > 2
    }
    
    func isNotRoot(wird: String) -> Bool {
        return wird != rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
