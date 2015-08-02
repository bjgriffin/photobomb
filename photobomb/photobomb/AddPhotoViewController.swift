//
//  AddPhotoViewController.swift
//  photobomb
//
//  Created by BJ Griffin on 8/2/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func uploadPhotoAction() {
        if let image = photo.image {
            WebServiceManager.sharedInstance.savePhoto(image) {
                error -> Void in
                if error == nil {
                    CoreDataManager.sharedInstance.deleteCoreDataPhotos() {
                        WebServiceManager.sharedInstance.fetchPhotos() {
                            (fetchedResultsController, error) -> Void in
                            if error == nil {
                                dispatch_async(dispatch_get_main_queue()) {
                                    NSNotificationCenter.defaultCenter().postNotificationName("AddPhotoWillDismiss", object: nil)
                                    self.dismissViewControllerAnimated(true, completion: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
