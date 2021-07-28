//
//  ListService.swift
//  CleanVIP
//
//  Created by Alexandre C do Carmo on 27/07/21.
//

import Foundation
import CoreData

protocol ListService: AnyObject {
    func getItems() throws -> [Items]
    func addItems(text: String) throws -> Items
    func deleteItem(with id: String) throws
    func getItem(with id: String) throws -> Items?
}

class ListServiceImplementation: ListService {
    
    let persistentContainer = PersistentContainerProvider.getInstance()
    lazy var managedContext: NSManagedObjectContext = { persistentContainer.viewContext
    }()
    
    func getItems() throws -> [Items] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Title")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if let titles = result as? [Items] {
                return titles
            } else {
                return []
            }
        } catch {
            print("Couldn't get titles")
            return []
        }
    }
    
    func addItems(text: String) throws -> Items {
        let title = NSEntityDescription.insertNewObject(forEntityName: "Title", into: managedContext) as! Items
        title.text = text
        title.id = UUID().uuidString
        
        do {
            try managedContext.save()
        } catch {
            print("Couldn't add a title")
        }
        
        return title
    }
    
    func deleteItem(with id: String) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Title")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if let objectToDelete = result.first as? NSManagedObject {
                managedContext.delete(objectToDelete)
                
                do {
                    try managedContext.save()
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getItem(with id: String) throws -> Items? {
        let predicate = NSPredicate(format: "id = %@", id)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Title")
        fetchRequest.predicate = predicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if let title = result.first as? Items  {
                return title
            }
        } catch {
            print("Couldn't get title")
        }
        
        return nil
    }
}
