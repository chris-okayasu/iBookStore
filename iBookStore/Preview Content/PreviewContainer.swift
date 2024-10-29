//
//  PreviewContainer.swift
//  iBookStore
//
//  Created by chris on 2024/10/29.
//

import Foundation
import SwiftData
struct Preview{
    let container: ModelContainer
    init(){
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            container = try ModelContainer(for: Book.self, configurations: config)
        } catch {
            fatalError("Could not create preview container: \(error)")
        }
    }
    
    func addExamples(_ examples: [Book]){
        Task{ @MainActor in
            examples.forEach {e in
                container.mainContext.insert(e)
            }
        }
    }
}
