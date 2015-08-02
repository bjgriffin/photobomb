//
//  AppDataManager.swift
//  photobomb
//
//  Created by BJ Griffin on 7/18/15.
//  Copyright © 2015 mojo. All rights reserved.
//

class AppDataManager {
    class var sharedInstance : AppDataManager {
        struct Static {
            static let instance : AppDataManager = AppDataManager()
        }
        return Static.instance
    }
    
}
