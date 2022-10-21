//
//  ContentView.swift
//  Bookworm
//
//  Created by Richard-Bollans, Jack on 21.10.2022.
//

import SwiftUI

//struct ContentView: View {
//    @State var rememberMe: Bool = false
//    var body: some View {
//        VStack {
//            PushButton(title: "Remember Me", isOn: $rememberMe)
//            Text(rememberMe ? "On" : "Off")
//        }
//    }
//}

//struct ContentView: View {
//    @AppStorage("notes") private var notes = ""
//
//    var body: some View {
//        NavigationView {
//            TextEditor(text: $notes)
//                .navigationTitle("Notes")
//                .padding()
//        }
//    }
//}

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                try? moc.save()
            }
        }
    }
}
struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(colors: isOn ? onColors : offColors, startPoint: .top, endPoint: .bottom))
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
