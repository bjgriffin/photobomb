//
//  UIViewController+Ext.swift
//  photobomb
//
//  Created by BJ Griffin on 7/11/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func getLoginViewController() -> UIViewController {
        let storyboard = UIStoryboard.loginStoryboard()
        return storyboard.instantiateViewControllerWithIdentifier("Login")
    }

    class func getSearchTableViewController() -> UITableViewController {
        let storyboard = UIStoryboard.searchStoryboard()
        return storyboard.instantiateViewControllerWithIdentifier("Search") as! UITableViewController
    }
}