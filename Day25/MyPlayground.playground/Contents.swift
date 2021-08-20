import UIKit

var greeting = "Hello, playground"
-1 % 3

let word = "campg"
let checker = UITextChecker()

let range = NSRange(location: 0, length: word.utf16.count)
let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "fi_FI")
let allGood = misspelledRange.location == NSNotFound
