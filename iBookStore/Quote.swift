//
//  Quote.swift
//  iBookStore
//
//  Created by chris on 2024/10/30.
//

import Foundation
import SwiftData

@Model
class Quote {
    var creationDate: Date = Date.now
    var text: String
    var page: String?
    
    // I don't need creationDate since it has a default value already
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
    // one to many relationship, the quote is from one Book
    var book: Book?
}
