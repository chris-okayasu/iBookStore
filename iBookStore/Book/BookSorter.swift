//
//  BookSorter.swift
//  iBookStore
//
//  Created by chris on 2024/10/29.
//

import SwiftUI
import SwiftData
import PhotosUI

struct BookSorter: View {
    // Get Book model and sort by title
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]

    init(sortOrder: SortOrder, filterString: String){
        let sortDescriptions: [SortDescriptor<Book>] = switch sortOrder {
        case .title: [SortDescriptor(\.title)]
        case .author: [SortDescriptor(\.author)]
        case .status: [SortDescriptor(\.status), SortDescriptor(\.title)]
        }
        
        let predicate = #Predicate<Book> {book in
            book.title.localizedStandardContains(filterString)
            || book.author.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _books = Query(filter: predicate, sort: sortDescriptions)
    }
    var body: some View {
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
                                    if let genres = book.genres {
                                        ViewThatFits{
                                            ScrollView(.horizontal, showsIndicators: false){
                                                GenresStackView(genres: genres)
                                            }
                                        }
                                    }
                                }
                                if let bookCoverData = book.bookCover,
                                   let uiImage = UIImage(data: bookCoverData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 100)
                                } else {
                                    
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 75, height: 100)
                                        .tint(.primary)
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { i in
                            let book = books[i]
                            print("Deleting: \(book.title)")
                            context.delete(book)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context after deleting: \(error)")
                            }
                        }
                    }
                    
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookSorter(sortOrder: .title, filterString: "")
        .modelContainer(preview.container)
}
