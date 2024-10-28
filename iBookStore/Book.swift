//
//  Book.swift
//  iBookStore
//
//  Created by chris on 2024/10/28.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateComplete: Date
    var sumary: String
    var rating: Int?
    var status: Status // manage by enum Status
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateComplete: Date = Date.distantPast,
        sumary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateComplete = dateComplete
        self.sumary = sumary
        self.rating = rating
        self.status = status
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
