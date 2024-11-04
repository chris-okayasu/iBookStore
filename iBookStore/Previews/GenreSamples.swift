//
//  GenreSamples.swift
//  iBookStore
//
//  Created by chris on 2024/10/31.
//

import Foundation
extension Genre {
    static var sampleGenres: [Genre] {
        [
            Genre(name: "Fiction", color: "00FF00"),
            Genre(name: "Non-Fiction", color: "0000FF"),
            Genre(name: "Science Fiction", color: "FF0000"),
            Genre(name: "History", color: "FFFF00")
        ]
    }
}
