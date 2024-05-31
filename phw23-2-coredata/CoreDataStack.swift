//
//  CoreDataStack.swift
//  phw23-2-coredata
//
//  Created by jasonhung on 2024/5/31.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "phw23_2_coredata")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private init() {}
}
