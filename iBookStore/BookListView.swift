//
//  ContentView.swift
//  iBookStore
//
//  Created by chris on 2024/10/28.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @State private var createNewBook: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
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
    BookListView()
}
