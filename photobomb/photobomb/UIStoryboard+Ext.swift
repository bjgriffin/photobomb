//
//  UIStoryboard+Ext.swift
//  photobomb
//
//  Created by BJ Griffin on 7/11/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {

    class func searchStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Search", bundle: nil)
    }
    
    class func addPhotoStoryboard() -> UIStoryboard {
        return UIStoryboard(name:"AddPhoto", bundle:nil)
    }
    
    class func loginStoryboard() -> UIStoryboard {
        return UIStoryboard(name:"Login", bundle:nil)
    }
    
}