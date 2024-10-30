//
//  Book.swift
//  iBookStore
//
//  Created by chris on 2024/10/28.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Book { // Class is used when the app starts, that is why it crushed when new property was added (recommended by)
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateComplete: Date
    @Attribute(originalName: "sumary") // summary name was changed to synopsis, in order to  refere to original name on db we have to add that attribute (this also will modify the column name on the table)
    var synopsis: String
    var rating: Int?
    var status: Status.RawValue // manage by enum Status
    var recommendedBy: String = "" // set an empty string since the db already has some books
    
    // one to many relationship, this book has many quotes
    var quotes: [Quote]?
    
    init( // the init is used when new book is created NOT when the app is started (recommendedBy issue and migrations)
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateComplete: Date = Date.distantPast,
        synopsis: String = "",
        rating: Int? = nil,
        status: Status = .onShelf,
        recommendedBy: String = "---"
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateComplete = dateComplete
        self.synopsis = synopsis
        self.rating = rating
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .onShelf: Image(
            systemName: "checkmark.diamond.fill"
        )
        case .inProgress: Image(
            systemName: "book.fill"
        )
        case .completed: Image(
            systemName: "books.vertical.fill"
        )
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }
    var desc: String {
        switch self {
        case .onShelf: return "On Shelf"
        case .inProgress: return "In Progress"
        case .completed: return "Completed"
        }
    }
}
