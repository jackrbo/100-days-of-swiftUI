import UIKit
import Foundation
import NaturalLanguage

let text = "kissassa"
let range: Range<String.Index> = text.startIndex..<text.endIndex
let tagger = NLTagger(tagSchemes: [.lemma])
//tagger.setLanguage(.italian, range: range)
tagger.string = text
                   

//let orthography = NSOrthography.defaultOrthography(forLanguage: "fi-FI")
//tagger.setOrthography(orthography, range: range)

tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lemma) { tag, range in
   let stemForm = tag?.rawValue ?? String(text[range])
   print(stemForm, terminator: "")
   return true
}

print(tagger.dominantLanguage?.rawValue)

let tokenizer = NLTokenizer(unit: .sentence)
tokenizer.setLanguage(.finnish)
tokenizer.string = text

let tokens = tokenizer.tokens(for: text.startIndex..<text.endIndex)


let finnish = NLLanguageRecognizer.dominantLanguage(for: text)


