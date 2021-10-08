//
//  ContentView.swift
//  Bookworm
//
//  Created by Jack on 8.10.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Student.entity(),
        sortDescriptors: [],
        animation: .default)
    private var students: FetchedResults<Student>

    var body: some View {
        VStack {
            NavigationView{
                List {
                    ForEach(students, id: \.id) { student in
                        
                            Text(student.name!)
                                .font(.largeTitle)
                        
                    }
                    .onDelete(){ offset in
                        deleteStudent(offsets: offset)
                    }
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: viewContext)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            
        }
    }

    private func addStudent() {
        withAnimation {
            let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
            let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

            let chosenFirstName = firstNames.randomElement()!
            let chosenLastName = lastNames.randomElement()!

            let newStudent = Student(context: viewContext)
            newStudent.id = UUID()
            newStudent.name = "\(chosenFirstName) \(chosenLastName)"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteStudent(offsets: IndexSet) {
        withAnimation {
            offsets.map { students[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
