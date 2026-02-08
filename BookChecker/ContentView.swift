//
//  ContentView.swift
//  BookChecker
//
//  Created by Adam Herman on 08/02/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddBookScreen: Bool = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(books){ book in
                    NavigationLink(destination: BookDetailsView(book: book)){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.title)
                            Spacer()
                            VStack(alignment: .leading, spacing: 5){
                                Text(book.title)
                                    .font(.headline.bold())
                                Text(book.author)
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                    .listRowBackground((book.rating == 1) ? Color.red : Color.white)
                }
                .onDelete(perform: removeBook)
            }
            .navigationTitle("Book reviewer")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.bottom, 5)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add Book", systemImage: "plus"){
                        showingAddBookScreen.toggle()
                    }
                }
            }
        }.sheet(isPresented: $showingAddBookScreen){
            AddBookView()
        }
    }
    
    func removeBook(at offsets: IndexSet){
        for ofsset in offsets{
            let book = books[ofsset]
            
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
