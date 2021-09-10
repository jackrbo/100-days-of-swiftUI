import UIKit

var greeting = "Hello, playground"
let date = Date()
let calendar = Calendar.current
let day = calendar.component(.day, from: date)
//let month = calendar.component(., from: <#T##Date#>)


let formatter = DateFormatter()
formatter.dateStyle = .medium
formatter.string(from: date)
