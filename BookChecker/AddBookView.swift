//
//  AddBookView.swift
//  BookChecker
//
//  Created by Adam Herman on 08/02/2026.
//

import Foundation
import SwiftUI
import SwiftData

struct AddBookView: View {
    
    let types = ["Horror", "Fantasy", "Mystery", "Thriller", "Kids", "Romance", "Poetry"]
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 1
    @State private var type = "Horror"
    @State private var review = ""
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Book title", text: $title)
                TextField("Author's name", text: $author)
                
                Picker("Pick book type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                RatingView(rating: $rating)
            }
            .buttonStyle(.plain)
            .font(.title3.bold())
            
            Section("Add review"){
                TextEditor(text: $review)
            }
            .font(.title3.bold())
            
            Button("Save"){
                let newBook = Book(title: title, author: author, type: type, review: review, rating: rating, date: Date())
                modelContext.insert(newBook)
                dismiss()
            }
            .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .font(.headline)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                Capsule().fill((title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) ? Color.gray : Color.black)
            )
            .foregroundStyle(.white)  

            
            .navigationTitle("Book checker")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview{
    AddBookView()
}

