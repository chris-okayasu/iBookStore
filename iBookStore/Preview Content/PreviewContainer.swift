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
    
    init(_ models: any PersistentModel.Type...){
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create preview container: \(error)")
        }
    }
    
    func addExamples(_ examples: [any PersistentModel]){
        Task{ @MainActor in
            examples.forEach {e in
                container.mainContext.insert(e)
            }
        }
    }
}
