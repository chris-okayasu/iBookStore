//
//  BookSamples.swift
//  iBookStore
//
//  Created by chris on 2024/10/29.
//

import Foundation

extension Book {
    static let lastWeek = Calendar.current.date(
        byAdding: .day,
        value: -7,
        to: Date.now
    )!
    static let lastMonth = Calendar.current.date(
        byAdding: .month,
        value: -1,
        to: Date.now
    )!
    static var sampleBooks: [Book] {
        [
            Book(
                title: "So So no Frieren",
                author: "Kanehito Yamada",
                dateAdded: lastMonth,
                dateStarted: lastWeek,
                synopsis: "The story follows Frieren, an elf who went on an epic adventure with a hero to save the world. After the death of her human friends, Frieren embarks on a new journey to better understand human life and emotions.",
                rating: 5,
                status: Status.completed,
                recommendedBy: "TV Tokyo"
            ),
            Book(
                title: "Oshi no Ko",
                author: "Aka Akasaka",
                dateAdded: lastWeek,
                dateStarted: Date.now,
                synopsis: "The life of a Japanese idol takes an unexpected turn when it is revealed that she is pregnant. The story follows her children, who have mysterious memories of their past lives.",
                status: Status.inProgress,
                recommendedBy: "Japanese Restaurants"

            ),
            Book(
                title: "Attack on Titan",
                author: "Hajime Isayama",
                dateAdded: lastMonth,
                dateStarted: lastWeek,
                synopsis: "In a post-apocalyptic world where humanity lives in cities surrounded by enormous walls to protect themselves from the titans, giant creatures that devour humans, a young man named Eren Yeager embarks on a mission to avenge his mother and save humanity.",
                rating: 5,
                status: Status.completed,
                recommendedBy: "Everyone"
            ),
            Book(
                title: "Dragon Ball Super",
                author: "Akira Toriyama",
                dateAdded: lastWeek,
                dateStarted: Date.now,
                synopsis: "The story continues after the events of Dragon Ball Z, where Goku and his friends face new cosmic threats and powerful characters as they search for the dragon balls and protect the universe.",
                status: Status.onShelf,
                recommendedBy: "Dragon Ball Fans"
            )
        ]
    }
}
