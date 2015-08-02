//
//  UserManager.swift
//  photobomb
//
//  Created by BJ Griffin on 7/19/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit
import Parse

class UserManager: NSObject {
    class var sharedInstance : UserManager {
        struct Static {
            static let instance : UserManager = UserManager()
        }
        return Static.instance
    }
    
    func register() {
//        var user = PFUser()
//        user.username = "myUsername"
//        user.password = "myPassword"
//        user.email = "email@example.com"
//        // other fields can be set just like with PFObject
//        user["phone"] = "415-392-0202"
//        
//        user.signUpInBackgroundWithBlock {
//            (succeeded: Bool, error: NSError?) -> Void in
//            if let error = error {
//                let errorString = error.userInfo?["error"] as? NSString
//                //
//            } else {
//                //
//            }
//        }
    }
    
    func signUp() {
        PFUser.logInWithUsernameInBackground("myname", password:"mypass") {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
            } else {
                // The login failed. Check error to see why.
            }
        }
    }
    
}
