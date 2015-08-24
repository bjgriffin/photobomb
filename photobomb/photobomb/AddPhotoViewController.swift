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
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func uploadPhotoAction() {
        if let image = photo.image {
            WebServiceManager.sharedInstance.savePhoto(image, caption:captionTextView.text, hashtags:getHashtags()) {
                error -> Void in
                if error == nil {
                    CoreDataManager.sharedInstance.deleteCoreDataPhotos() {
                        AppDataManager.sharedInstance.fetchPhotos() {
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func getHashtags() -> [String] {
        let words = captionTextView.text.characters.split {$0 == " "}.map { String($0) }
        var hashtags = [String]()
        
         for word in words {
                 if word.hasPrefix("#") {
                        let digits = NSCharacterSet.decimalDigitCharacterSet()
        
                        if let _ = word.rangeOfCharacterFromSet(digits) {
                                // hashtag contains a number, like "#1"
                                    // so don't make it clickable
                            } else {
                                hashtags.append(word)
                            }
                        
                    }
            }
        
        return hashtags
    }
    
    private func moveKeyboard(moved:Bool, keyboardHeight:CGFloat) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        
        if moved {
            view.frame.origin.y -= keyboardHeight
            view.frame.size.height += keyboardHeight
        } else {
            view.frame.origin.y += keyboardHeight
            view.frame.size.height -= keyboardHeight
        }
        
        UIView.commitAnimations()
    }
    
    func keyboardWillShow(notification:NSNotification) {
        let keyboardHeight = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size.height
        if view.frame.origin.y >= 0 {
            moveKeyboard(true, keyboardHeight: keyboardHeight!)
        } else if view.frame.origin.y < 0 {
            moveKeyboard(false, keyboardHeight: keyboardHeight!)
        }
    }
    
    func keyboardWillHide(notification:NSNotification) {
        let keyboardHeight = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size.height
        
        if view.frame.origin.y >= 0 {
            moveKeyboard(true, keyboardHeight: keyboardHeight!)
        } else if view.frame.origin.y < 0 {
            moveKeyboard(false, keyboardHeight: keyboardHeight!)
        }
    }

}
