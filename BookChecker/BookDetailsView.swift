//
//  BookDetailsView.swift
//  BookChecker
//
//  Created by Adam Herman on 08/02/2026.
//

import Foundation
import SwiftUI
import SwiftData

struct BookDetailsView: View {
    let book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteConfirmation: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.type)
                        .resizable()
                        .scaledToFit()
                    
                    Text(book.type.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(.capsule)
                        .offset(x: -5, y: -5)
                }
                VStack(spacing: 15){
                    Text(book.author)
                        .font(.title.bold())
                    Text(book.review)
                }
                .padding(.top, 25)
            }
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .safeAreaInset(edge: .bottom) {
                RatingView(rating: .constant(book.rating))
                    .font(.title)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
            }
            .alert("Delete book", isPresented: $showingDeleteConfirmation){
                Button("Delete", role: .destructive, action: deleteBook)
                Button("Cancel", role: .cancel){}
            } message: {
                    Text("Are you sure you want to delete this book?")
                }
            .toolbar{
                Button("Delete this book", systemImage: "trash"){
                    showingDeleteConfirmation = true
                }
            }
        }
    }
    
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
}


#Preview {
    
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example  = Book(title: "Lord Of Rings", author: "J.R.R. Tolkien", type: "Fantasy", review: "Nice book to read. Enjoyed it.", rating: 4)
        
        return BookDetailsView(book: example)
            .modelContainer(container)
    }
    catch{
        return Text("Unable to create preview: \(error.localizedDescription)")
    }
    
}
