//
//  QuoteListView.swift
//  iBookStore
//
//  Created by chris on 2024/10/30.
//

import SwiftUI

struct QuotesListView: View {
    @Environment(\.modelContext) private var modelContext
    let book: Book
    
    @State private var text: String = ""
    @State private var page: String = ""
    @State private var selectedQuote: Quote?
    
    var isEditing: Bool {
        selectedQuote != nil
    }
    
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page"){
                    TextField("Page", text: $page)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }
                if isEditing {
                    Button("Cancel") {
                        page = ""
                        text = ""
                        selectedQuote = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedQuote?.page = page.isEmpty ? nil : page
                        selectedQuote?.text = text
                        page = ""
                        text = ""
                        selectedQuote = nil
                    } else {
                        let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
                        book.quotes?.append(quote)
                        text = ""
                        page = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            TextEditor(text: $text)
                .border(.secondary)
                .frame(height: 100)
        }
        .padding(.horizontal)
        List {
            let sortedQuotes = book.quotes?.sorted(using: KeyPathComparator(\Quote.creationDate)) ?? []
            ForEach(sortedQuotes) { q in
                VStack(alignment: .leading){
                    Text(q.creationDate, format: .dateTime.year().month().day())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(q.text)
                    HStack {
                        Spacer()
                        if let page = q.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedQuote = q
                    text = q.text
                    page = q.page ?? ""
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    indexSet.forEach {index in
                        let quote = sortedQuotes[index]
                        book.quotes?.forEach({bookQuote in
                            if quote.id == bookQuote.id {
                                modelContext.delete(bookQuote)
                            }
                        })
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(book.title) - Quotes")
    }
}


#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExamples(books)
    return NavigationStack{
        QuotesListView(book: books[1])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
