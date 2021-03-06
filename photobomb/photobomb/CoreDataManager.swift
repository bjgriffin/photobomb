//
//  CoreDataManager.swift
//  photobomb
//
//  Created by BJ Griffin on 7/18/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import CoreData

class CoreDataManager {
    class var sharedInstance : CoreDataManager {
        struct Static {
            static let instance : CoreDataManager = CoreDataManager()
        }
        return Static.instance
    }
    
    var photosFetchedResultsController : NSFetchedResultsController?
    
    // MARK: - Core Data Object Methods
    
    func deleteCoreDataPhotos(completion:() -> ()) {
        let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Photo")
        fetchRequest.includesPropertyValues = false
        
        do {
        let photos = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Photo]
            if let photos = photos {
                for photo in photos {
                    managedObjectContext.deleteObject(photo)
                }
            }
            completion()
        } catch let error {
            print("\(error)")
        }
        
        do {
            try managedObjectContext.save()
        } catch let error {
            print("\(error)")
        }
    }
    
    func savePhoto(imageIdentifier:String, createdAt:NSDate, caption:String) {
        if let photo = NSEntityDescription.insertNewObjectForEntityForName("Photo", inManagedObjectContext: managedObjectContext) as? Photo {
            photo.imageIdentifier = imageIdentifier
            photo.createdAt = createdAt
            photo.caption = caption
        }

        saveContext()
    }
    
    func fetchPhotos() -> NSFetchedResultsController? {
        if photosFetchedResultsController == nil {
            let fetchRequest:NSFetchRequest = NSFetchRequest(entityName: "Photo")
            let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
            let sortDescriptors = [sortDescriptor]
            
            fetchRequest.sortDescriptors = sortDescriptors
            fetchRequest.fetchBatchSize = 50
            photosFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        }

        do {
            try photosFetchedResultsController?.performFetch()
        } catch let error {
            print("\(error)")
        }
    
        return photosFetchedResultsController
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "test.test" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("photobomb", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("photobomb.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType:.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
