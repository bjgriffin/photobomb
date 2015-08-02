//
//  UIViewController+Camera.swift
//  photobomb
//
//  Created by BJ Griffin on 7/25/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit

extension SearchTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func getImagePicker() -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        return imagePicker
    }
    
    func showPhotoActionSheet() {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
        let imagePicker = getImagePicker()

        let takePictureAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            imagePicker.sourceType = .Camera
            dispatch_async(dispatch_get_main_queue()) {
                actionSheetController.dismissViewControllerAnimated(false, completion: nil)
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        actionSheetController.addAction(takePictureAction)
        
        let choosePictureAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            imagePicker.sourceType = .PhotoLibrary
            dispatch_async(dispatch_get_main_queue()) {
                actionSheetController.dismissViewControllerAnimated(false, completion: nil)
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = view
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}
