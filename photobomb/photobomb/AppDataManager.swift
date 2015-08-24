//
//  AppDataManager.swift
//  photobomb
//
//  Created by BJ Griffin on 7/18/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import CoreData
import Parse

class AppDataManager {
    lazy var photoPFFiles = [String:PFFile]()
    lazy var photosCache = NSCache()

    class var sharedInstance : AppDataManager {
        struct Static {
            static let instance : AppDataManager = AppDataManager()
        }
        return Static.instance
    }
    
    func fetchPhotos(completion:(fetchedResultsController:NSFetchedResultsController?, error:NSError?) -> Void) {
        let query = PFQuery(className: "Photo")
        //TODO: Add query to limit number of fetched photos
        
        query.findObjectsInBackgroundWithBlock ({(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                for photo in objects as! [PFObject] {
                    let imageFile = photo["image"] as? PFFile
                    let identifier = photo["imageIdentifier"] as? String
                    let caption = photo["caption"] as? String
                    
                    if let identifier = identifier {
                        self.photoPFFiles[identifier] = imageFile
                    
                        CoreDataManager.sharedInstance.savePhoto(identifier, createdAt: photo.createdAt ?? NSDate(), caption:caption ?? "")
                    }
                }
                
                let fetchedResultsController = CoreDataManager.sharedInstance.fetchPhotos()
                completion(fetchedResultsController: fetchedResultsController, error: nil)
            } else {
                print("Error in retrieving \(error)")
                completion(fetchedResultsController: nil, error: error)
            }
            
        })
    }
    
}
