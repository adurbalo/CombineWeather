//
//  StorageProvider.swift
//  CombineWeather
//
//  Created by Andrii Durbalo on 10.02.2021.
//

import Foundation
import CoreData

class StorageProvider {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        
        persistentContainer = NSPersistentContainer(name: "Storage")
        persistentContainer.loadPersistentStores { (desc, error) in
            
            if let error = error {
                fatalError("error: \(error.localizedDescription)")
            }
            print(desc)
        }
    }
}


extension StorageProvider {
    
    func save(city: CitiesListViewController.City) {
        
        let newCity = MOCity(context: persistentContainer.viewContext)
        newCity.id = Int64(city.id)!
        newCity.name = city.name
        newCity.country = "UA"
        newCity.state = ""
        
        let coord = MOCoordinate(context: persistentContainer.viewContext)
        coord.lat = 46.477474
        coord.lon = 30.732622
            
        newCity.coord = coord
        
        do {
            try persistentContainer.viewContext.save()
            print("Saved")
        } catch {
            print("failer: \(error)")
        }
        
    }
    
    func getAllCities() -> [MOCity] {
        
        let fetchRequest: NSFetchRequest<MOCity> = MOCity.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
}
