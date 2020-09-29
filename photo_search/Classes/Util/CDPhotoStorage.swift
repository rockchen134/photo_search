//
//  CDPhotoStorage.swift
//  photo_search
//
//  Created by Rock Chen on 2020/9/28.
//

import Foundation
import CoreData

class CDPhotoStorage {
    static func insert(_ id: String, title: String, url: String) {
        let stack = CoreDataStack.shared
        let context = stack.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "CDPhoto", into: context) as! CDPhoto
        
        entity.id = id
        entity.title = title
        entity.url = url
        
        stack.saveContext()
    }
    
    static func fetch(_ id: String? = nil) -> [CDPhoto] {
        let stack = CoreDataStack.shared
        let context = stack.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDPhoto")
                
        do {
            if let _id = id {
                request.predicate = NSPredicate(format: "id == %@", _id)
            }
            
            let result = try context.fetch(request) as! [CDPhoto]
            
            return result
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    static func delete(_ photo: CDPhoto) {
        let stack = CoreDataStack.shared
        let context = stack.persistentContainer.viewContext
        
        context.delete(photo)
        stack.saveContext()
    }
}
