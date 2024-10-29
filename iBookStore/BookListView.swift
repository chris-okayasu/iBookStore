//
//  ContentView.swift
//  iBookStore
//
//  Created by chris on 2024/10/28.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    // Get Book model and sort by title
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.title) private var books: [Book]
    @State private var createNewBook: Bool = false
    var body: some View {
        NavigationStack {
            Group{
                if books.isEmpty {
                    ContentUnavailableView("Enter your first book", systemImage: "book.fill")
                }else{
                    List{
                        ForEach(books) { book in
                            NavigationLink {
                                EditBookView(book: book)
                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading){
                                        Text(book.title)
                                            .font(.title2)
                                        Text(book.author)
                                            .foregroundStyle(.secondary)
                                        if let rating = book.rating {
                                            HStack {
                                                ForEach(1..<rating, id: \.self){ _ in
                                                    Image(systemName: "star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete { index in
                            index.forEach{ i in
                                let book = books[i]
                                print("Deleting: \(book.title)")
                                context.delete(book)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("My Manga")
            .toolbar{
                Button{
                    createNewBook = true
                }label:{
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createNewBook){
                NewBookView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookListView()
        .modelContainer(preview.container)
}
