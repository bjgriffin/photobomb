//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var descr: String?
    @NSManaged var email: String?
    @NSManaged var name: String?
    @NSManaged var password: String?
    @NSManaged var syncStatus: NSNumber?
    @NSManaged var photos: NSSet?
    @NSManaged var comments: Comment?

}
