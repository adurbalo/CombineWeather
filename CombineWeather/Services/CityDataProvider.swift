//
//  CityDataProvider.swift
//  CombineWeather
//
//  Created by Andrii Durbalo on 11.02.2021.
//

import Foundation
import CoreData
import Combine

class CityDataProvider: NSObject {
    
    let storage: StorageProvider
    private let fetchedController: NSFetchedResultsController<MOCity>
    
    init(storage: StorageProvider) {
        self.storage = storage
        
        let request: NSFetchRequest<MOCity> = MOCity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        self.fetchedController = NSFetchedResultsController(fetchRequest: request,
                                                            managedObjectContext: self.storage.persistentContainer.viewContext,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil)
        
        super.init()
        
        self.fetchedController.delegate = self
        do {
            try self.fetchedController.performFetch()
        } catch {
            print("Unable fetch: \(error)")
        }
        
        guard let objects = fetchedController.fetchedObjects else { return }
        
        objects.forEach { (res) in
            
            print(res.name)
        }
    }
}

extension CityDataProvider: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let objects = controller.fetchedObjects else { return }
        
        objects.forEach { (res) in
            
            print(res)
        }
    }
}
