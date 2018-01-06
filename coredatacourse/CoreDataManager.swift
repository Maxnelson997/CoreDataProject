//
//  CoreDataManager.swift
//  coredatacourse
//
//  Created by Max Nelson on 1/5/18.
//  Copyright © 2018 AsherApps. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IntermediateTraining")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("loading of store failed: \(err)")
            }
        }
        return container
    }()
    
}
