//
//  ContentView.swift
//  iBookStore
//
//  Created by chris on 2024/10/28.
//

import SwiftUI
import SwiftData

enum SortOrder: LocalizedStringResource, CaseIterable, Identifiable {
    case title
    case author
    case status
    var id: Self { self }
}

struct BookListView: View {

    @State private var createNewBook: Bool = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            BookSorter(sortOrder: sortOrder, filterString: filter)
                .searchable(text: $filter, prompt: "Search by title or author.")
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

#Preview("English") {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    preview.addExamples(Genre.sampleGenres)
    return NavigationStack{
        BookListView()
    }
        .modelContainer(preview.container)
}


#Preview("Japanese") {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    preview.addExamples(Genre.sampleGenres)
    return NavigationStack{
        BookListView()
    }
        .modelContainer(preview.container)
        .environment(\.locale, Locale(identifier: "ja_JP"))
}

#Preview("Spanish") {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    preview.addExamples(Genre.sampleGenres)
    return NavigationStack{
        BookListView()
    }
        .modelContainer(preview.container)
        .environment(\.locale, Locale(identifier: "es_ES"))
}
