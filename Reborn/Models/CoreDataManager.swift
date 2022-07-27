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
    var viewContext: NSManagedObjectContext {
        persistantContainer.viewContext
    }
    
    private init() {
        persistantContainer = NSPersistentContainer(name: "AnimalModel")
        persistantContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func save() -> Bool {
        do {
            try viewContext.save()
            return true
        } catch {
            viewContext.rollback()
            return false
        }
    }
    
    func saveAnimal(_ item: Item) -> Bool {
        guard let itemId = item.id else {
            print("cannot save cause id is nil")
            return false
        }
        
        let likedAnimal = LikedAnimal(context: viewContext)
        
        likedAnimal.id = itemId
        
        likedAnimal.detailImage = item.detailImage
        likedAnimal.noticeNumber = item.noticeNumber
        likedAnimal.noticeStartDate = item.noticeStartDate
        likedAnimal.noticeEndDate = item.noticeEndDate
        
        likedAnimal.kind = item.kind
        likedAnimal.color = item.color
        likedAnimal.birth = item.birth
        likedAnimal.sexCd = item.sexCd
        likedAnimal.neutralizationStatus = item.neutralizationStatus
        likedAnimal.weight = item.weight
        likedAnimal.descript = item.description
        likedAnimal.discoveredPlace = item.discoverdPlace
        
        likedAnimal.shelterName = item.shelterName
        likedAnimal.shelterAddress = item.shelterAddress
        likedAnimal.telNumber = item.telNumber
        
        return save()
    }
    
    func getAllLikedAnimals() -> [LikedAnimal] {
        let fetchRequest = LikedAnimal.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("failed to fetch liked animals")
            return []
        }
    }
    
    func getLikedAnimal(of item: Item) -> LikedAnimal? {
        guard let id = item.id else { return nil }
        
        let fetchRequest = LikedAnimal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            return try viewContext.fetch(fetchRequest).first
        } catch {
            print("failed to fetch liked animal")
            return nil
        }
    }
    
    func deleteLikedAnimal(_ likedAnimal: LikedAnimal) -> Bool {
        viewContext.delete(likedAnimal)
        return save()
    }
}
