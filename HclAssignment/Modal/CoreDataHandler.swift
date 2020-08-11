//
//  CoreDataHandler.swift
//  Assignment
//
//  Created by C02VG1PAG8WN on 10/08/20.
//  Copyright © 2020 admin. All rights reserved.
//
import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
  
    func someEntityExists(Entity: String,predicate : NSPredicate) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entity)
        fetchRequest.predicate = predicate
        
        var results: [NSManagedObject] = []
        if #available(iOS 10.0, *) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
         let managedContext = appDelegate.persistentContainer.viewContext

        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        }else{
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            do {
                results = try managedContext.fetch(fetchRequest)
            }
            catch {
                print("error executing fetch request: \(error)")
            }
        }
        return results.count > 0
    }

    func getEntity( entityName: String ) -> NSManagedObject {
       
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
            return NSManagedObject(entity: entity!, insertInto: managedContext)
        } else {
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
            return NSManagedObject(entity: entity!, insertInto: managedContext)
        }
    }
    
    func saveEntityDetails( entity:NSManagedObject, data:String, key:String ) {
        
        entity.setValue(data, forKey: key)
        do {
            try entity.managedObjectContext?.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func saveEntity( entity:NSManagedObject ) {
        
        do {
            
            try entity.managedObjectContext?.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateEntityDetails(  entityIndex:Int, entity:NSManagedObject, dataArray:[AnyObject], keyArray:[String] ) {
        
        for index in 0...dataArray.count - 1 {
            entity.setValue(dataArray[index], forKey: keyArray[index])
        }
        do {
            try entity.managedObjectContext?.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateEntity(entity:NSManagedObject){
        do {
            try entity.managedObjectContext?.save()
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    func updateEntity(  entityIndex:Int, entity:NSManagedObject, data:AnyObject, key:String ) {
        
        entity.setValue(data, forKey: key)
        
        do {
            try entity.managedObjectContext?.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func fetchEntityDetails( entityName: String ) -> [NSManagedObject] {
          let entity : [NSManagedObject] = []
        if #available(iOS 10.0, *) {
        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            do {
                return try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            } catch let error as NSError {
                print(error)
                let entity : [NSManagedObject] = []
                return entity
            }
        }
   
        }else{
            if  let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.managedObjectContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                do {
                    return try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                } catch let error as NSError {
                    print(error)
                    let entity : [NSManagedObject] = []
                    return entity
                }
            }
        }
      
        return entity
    }
    
    func fetchEntityDetailsWithRequestPredicate(entityName: String, predicate : NSPredicate ) -> [NSManagedObject] {
         let entity : [NSManagedObject] = []
        if #available(iOS 10.0, *) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = predicate
        do {
            return try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print(error)
           
        }
        }else{
            if  let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedContext = appDelegate.managedObjectContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                fetchRequest.predicate = predicate
                do {
                    return try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                } catch let error as NSError {
                    print(error)
                    
                }
        }
        }
        return entity
    }
    
    func fetchEntityDetailsWithRequestPredicateAndSortDescriptors(entityName: String, predicate : NSPredicate, key: String, isAscending : Bool ) -> [NSManagedObject] {
          let entity : [NSManagedObject] = []
       if #available(iOS 10.0, *) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: key, ascending: isAscending)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        do {
            return try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print(error)
           
        }
       }else{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: key, ascending: isAscending)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        do {
            return try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print(error)
            
        }
        }
   
        return entity
    }
    
    
    func deleteDataAtIndex( index:Int,  entity:[NSManagedObject]) {
        entity[index].managedObjectContext?.delete(entity[index])

        do {
            try entity[index].managedObjectContext?.save()
        } catch let error as NSError {
            print(error)
        }
    }
    func deleteSelectedEntity(entity:NSManagedObject) {
        entity.managedObjectContext?.delete(entity)
        
        do {
            try entity.managedObjectContext?.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllData( entityName : String ) {
        let entity = fetchEntityDetails(entityName: entityName)
        for index in entity {
            index.managedObjectContext?.delete(index)
        }
        
        do {
            try entity.first?.managedObjectContext?.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
}

