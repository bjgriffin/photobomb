//
//  WebServiceManager.swift
//  photobomb
//
//  Created by BJ Griffin on 7/18/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit
import Parse
import CoreData

class WebServiceManager {
    lazy var photosCache = NSCache()
    lazy var photoPFFiles = [String:PFFile]()
    
    class var sharedInstance : WebServiceManager {
        struct Static {
            static let instance : WebServiceManager = WebServiceManager()
        }
        return Static.instance
    }
    
    //MARK: Create Methods
    
    func savePhoto(image:UIImage, completion:(error:NSError?) -> ()) {
        let photo = PFObject(className: "Photo")
        
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            let imageFile = PFFile(data:data)
            photo["image"] = imageFile
            photo["imageIdentifier"] = NSUUID().UUIDString
        
            photo.saveInBackgroundWithBlock({(success:Bool, error:NSError?) -> Void in
                if !success {
                    if let error = error {
                        print(error)
                    }
                }
                completion(error: error)
            })
        }
    }
    
    func createComment() {
//        var list = PFObject(className: "Comment")
//        list["image"] = UIImage()
//        list["name"] = name
//        list.saveInBackgroundWithBlock({(success:Bool, error:NSError?) -> Void in
//            if success {
//                
//            } else {
//                if let error = error {
//                    print(error)
//                }
//            }
//        })
    }
    
    func createLocation() {
//        var list = PFObject(className: "Location")
//        list["image"] = UIImage()
//        list["name"] = name
//        list.saveInBackgroundWithBlock({(success:Bool, error:NSError?) -> Void in
//            if success {
//                
//            } else {
//                if let error = error {
//                    print(error)
//                }
//            }
//        })
    }
    
    //MARK: Fetch Methods
    
    func fetchUser() {
        let query = PFQuery(className:"User")
        query.getObjectInBackgroundWithId("xWMyZEGZ") {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error == nil && gameScore != nil {
                print(gameScore)
            } else {
                print(error)
            }
        }
    }
    
    func fetchPhotos(completion:(fetchedResultsController:NSFetchedResultsController?, error:NSError?) -> Void) {
        let query = PFQuery(className: "Photo")
        //TODO: Add query to limit number of fetched photos
        
        query.findObjectsInBackgroundWithBlock ({(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                for photo in objects as! [PFObject] {
                    let imageFile = photo["image"] as! PFFile
                    let identifier = photo["imageIdentifier"] as! String
                    
                    self.photoPFFiles[identifier] = imageFile
                    
                    CoreDataManager.sharedInstance.savePhoto(identifier, createdAt: photo.createdAt ?? NSDate())
                }
                
                let fetchedResultsController = CoreDataManager.sharedInstance.fetchPhotos()
                completion(fetchedResultsController: fetchedResultsController, error: nil)
            } else {
                print("Error in retrieving \(error)")
                completion(fetchedResultsController: nil, error: error)
            }
            
        })
    }
    
    func fetchComments() {
        let query = PFQuery(className:"Comment")
        query.getObjectInBackgroundWithId("xWMyZEGZ") {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error == nil && gameScore != nil {
                print(gameScore)
            } else {
                print(error)
            }
        }
    }
    
    func fetchLocation() {
        let query = PFQuery(className:"Location")
        query.getObjectInBackgroundWithId("xWMyZEGZ") {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error == nil && gameScore != nil {
                print(gameScore)
            } else {
                print(error)
            }
        }
    }
    
}
