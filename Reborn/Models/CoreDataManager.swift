//
//  CoreDataManager.swift
//  Reborn
//
//  Created by 김남건 on 2022/07/27.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistantContainer: NSPersistentContainer
    
    private init() {
        persistantContainer = NSPersistentContainer(name: "AnimalModel")
        persistantContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed to initialize \(error.localizedDescription)")
            }
        }
    }
}
