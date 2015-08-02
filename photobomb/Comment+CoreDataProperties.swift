//
//  Comment+CoreDataProperties.swift
//  photobomb
//
//  Created by BJ Griffin on 7/19/15.
//  Copyright © 2015 mojo. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Comment {

    @NSManaged var postDate: NSDate?
    @NSManaged var syncStatus: NSNumber?
    @NSManaged var text: String?
    @NSManaged var photo: NSManagedObject?
    @NSManaged var user: User?

}
