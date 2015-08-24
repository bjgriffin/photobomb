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
    
    class var sharedInstance : WebServiceManager {
        struct Static {
            static let instance : WebServiceManager = WebServiceManager()
        }
        return Static.instance
    }
    
    //MARK: Private Methods
    private func createHashtagPFObjectArray(hashtagStrings:[String], photo:PFObject) -> [PFObject] {
        var hashtagObjects = [PFObject]()
        for tag in hashtagStrings {
            let hashtag = PFObject(className: "Hashtag")
            hashtag["tag"] = tag
            hashtag["photo"] = photo
            
            hashtag.saveInBackgroundWithBlock({(success, error) -> Void in
                if !success {
                    if let error = error {
                        print(error)
                    }
                }
            })
            
            hashtagObjects.append(hashtag)
        }
        
        return hashtagObjects
    }
    
    //MARK: Create Methods
    
    func savePhoto(image:UIImage, caption:String, hashtags:[String], completion:(error:NSError?) -> ()) {
        let photo = PFObject(className: "Photo")
        
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            let imageFile = PFFile(data:data)
            photo["image"] = imageFile
            photo["caption"] = caption
            photo["hashtags"] = createHashtagPFObjectArray(hashtags, photo:photo)
            photo["imageIdentifier"] = NSUUID().UUIDString
            photo.saveInBackgroundWithBlock({(success, error) -> Void in
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
