import UIKit
import Foundation
let timeRemainingInSeconds = 3
let date = Date().timeIntervalSince1970
let timeToLock = date + Double(timeRemainingInSeconds)
extension Bool {
    var intValue: Int {
        self ? 1 : 0
    }
}

if true.intValue == 1 {
    print("E")
}
