//
//  iBookStoreApp.swift
//  iBookStore
//
//  Created by chris on 2024/10/28.
//

import SwiftUI
import SwiftData

@main
struct iBookStoreApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
//        .modelContainer(for: Book.self)
        .modelContainer(container)
    }
    init () {
        // option 2
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyManga", schema: schema)
        do{
            container = try ModelContainer(for: schema, configurations: config)
        }catch {
            fatalError("Could not load model container: \(error)")
        }
        //Option 1
        // With this new configuation we can set the name of the database and also the path (I am using the same but url: can set a different location if needed.) It looks better due to now is starting at the init() method
//        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "Manga.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: config)
//        } catch {
//            fatalError("Could not load model container: \(error)")
//        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
//        print(URL.documentsDirectory.path())
    }
}
