//
//  DataPersistanceManager.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/15.
//

import UIKit
import CoreData


class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    
    func clipDogfoodWith(model: Dogfood, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = DogfoodItem(context: context)
        
        item.name = model.name
        item.id = Int64(model.id)
        item.content = Int16(model.content)
        item.brand = model.brand
        item.category = model.category
        item.lifeStage = model.lifeStage
        item.ingredients = model.ingredients
        item.details = model.description
        item.madeIn = model.madeIn
        item.foodType = model.foodType
        item.imageUrl = model.imageUrl
        item.url = model.url
        item.price = Int16(model.price)
        item.sku = model.sku
        item.calories = Int16(Float(model.calories ?? 0))
        item.protein = Float(model.nutrition?.protein ?? 0)
        item.fat = Float(model.nutrition?.fat ?? 0)
        item.fiber = Float(model.nutrition?.fiber ?? 0)
        item.calcium = Float(model.nutrition?.calcium ?? 0)
        item.moisture = Float(model.nutrition?.moisture ?? 0)
        
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result<[DogfoodItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<DogfoodItem>
        
        request = DogfoodItem.fetchRequest()
        
        do {
            
            let dogfoods = try context.fetch(request)
            completion(.success(dogfoods))
            
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: DogfoodItem, completion: @escaping (Result<Void, Error>)-> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
        
    }
}
