//
//  UIImageView+Ext.swift
//  photobomb
//
//  Created by BJ Griffin on 8/1/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageView(identifier:String) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicator.frame = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, 25.0, 25.0)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let cache = WebServiceManager.sharedInstance.photosCache
            
            if let img = cache.objectForKey(identifier) as? UIImage {
                dispatch_async(dispatch_get_main_queue()) {
                    self.image = img
                    activityIndicator.stopAnimating()
                }
            } else {
                let files = WebServiceManager.sharedInstance.photoPFFiles
                
                if let file = files[identifier] {
                    file.getDataInBackgroundWithBlock {
                        (data: NSData?, error: NSError?) -> Void in
                        if error == nil {
                            if let data = data {
                                if let img = UIImage(data: data) {
                                    cache.setObject(img, forKey: identifier)
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.image = img
                                        activityIndicator.stopAnimating()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
