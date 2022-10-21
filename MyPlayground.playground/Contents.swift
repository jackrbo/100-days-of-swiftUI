
import Foundation
import AppKit



func waitFor(timeout: Double, debugString: String = "", condition: () -> Bool ) -> Bool {
    let date = Date()
    if debugString != "" {  print(debugString) }
    while !condition() && Date() < date + timeout {
        usleep(UInt32(0.1 * 1000000))
    }
    return condition()
}


func isAppRunning(bundleIdentifier: String) -> Bool {
    RunLoop.main.run(mode: .default, before: Date())
    return NSWorkspace.shared.runningApplications.first(where: { $0.bundleIdentifier == bundleIdentifier }) != nil
}

Date().formatted(date: .omitted, time: .complete)
usleep(UInt32(0.1 * 1000000))
Date().formatted(date: .omitted, time: .complete)
sleep(1)
Date().formatted(date: .omitted, time: .complete)
_ = waitFor(timeout: 30) {
    print("no")
  return isAppRunning(bundleIdentifier: "com.f-secure.fscunifiedui")
}

