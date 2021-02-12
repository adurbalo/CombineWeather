//
//  CityDataProvider.swift
//  CombineWeather
//
//  Created by Andrii Durbalo on 11.02.2021.
//

import Foundation
import CoreData
import Combine
import UIKit

class CityDataProvider: NSObject {
    
    let storage: StorageProvider
    @Published var snapshot: NSDiffableDataSourceSnapshot<Int, MOCity>?
    
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
    }
}

extension CityDataProvider: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
  
        self.snapshot = snapshot as NSDiffableDataSourceSnapshot<Int, MOCity>
    }
}
