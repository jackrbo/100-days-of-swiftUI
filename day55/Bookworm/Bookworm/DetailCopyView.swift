//
//  DetailView.swift
//  Bookworm
//
//  Created by Richard-Bollans, Jack on 18/01/2022.
//

import SwiftUI
import CoreData

struct DetailCopyView: View {
    
    var body: some View {
        ScrollView {
            ZStack( alignment: .bottomTrailing) {
                Image("Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text("FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text("Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text("No review")
                .padding()
            
            RatingView(rating: .constant(Int(4)))
                .font(.largeTitle)
        }
        .navigationTitle("unknown Book")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CopyDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        
        let book = Book(context: moc)
        book.title = "Test title"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailCopyView()
        }
    }
}
