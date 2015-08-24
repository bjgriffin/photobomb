//
//  Hashtag+CoreDataProperties.swift
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

extension Hashtag {

    @NSManaged var tag: String?
    @NSManaged var photos: NSSet?

}
