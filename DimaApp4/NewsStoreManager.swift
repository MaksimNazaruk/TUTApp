//
//  NewsStoreManager.swift
//  TUTBYApp
//
//  Created by Maksim Nazaruk on 2/23/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewsStoreManager: NSObject {

    var mainContext: NSManagedObjectContext?
    private var backgroundContext: NSManagedObjectContext?
    
    public func setupPersistanceStack() {
        
        guard let modelURL = Bundle.main.url(forResource:"Model", withExtension:"momd") else {
            fatalError("can't locate data base model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("can't load data base model")
        }
        
        let persistenceCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext?.persistentStoreCoordinator = persistenceCoordinator
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext?.persistentStoreCoordinator = persistenceCoordinator
    }
    
    public func allStoredNews() -> [NewsItem]? {
        
        let request = NewsItem.fetchRequest()
        request.
        
        return []
    }
    
}
