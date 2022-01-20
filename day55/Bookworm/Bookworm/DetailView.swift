//
//  DetailView.swift
//  Bookworm
//
//  Created by Richard-Bollans, Jack on 18/01/2022.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var alertShowing = false
    
    var body: some View {
        ScrollView {
            ZStack( alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .alert("Delete book", isPresented: $alertShowing) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .navigationTitle(book.title ?? "unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                alertShowing = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        
        let book = Book(context: moc)
        book.title = "Test title"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
