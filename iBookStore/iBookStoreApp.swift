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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
    init () {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
