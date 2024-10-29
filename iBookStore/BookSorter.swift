//
//  BookSorter.swift
//  iBookStore
//
//  Created by chris on 2024/10/29.
//

import SwiftUI
import SwiftData

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
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return BookSorter(sortOrder: .title, filterString: "")
        .modelContainer(preview.container)
}
