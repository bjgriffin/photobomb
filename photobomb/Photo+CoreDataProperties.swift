//
//  Photo+CoreDataProperties.swift
//  photobomb
//
//  Created by BJ Griffin on 8/9/15.
//  Copyright © 2015 mojo. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Photo {

    @NSManaged var createdAt: NSDate?
    @NSManaged var imageIdentifier: String?
    @NSManaged var syncStatus: NSNumber?
    @NSManaged var caption: String?
    @NSManaged var comments: NSSet?
    @NSManaged var hashtags: NSSet?
    @NSManaged var location: Location?
    @NSManaged var user: User?

}
