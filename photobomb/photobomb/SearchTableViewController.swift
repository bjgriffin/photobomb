//
//  SearchTableViewController.swift
//  photobomb
//
//  Created by BJ Griffin on 7/25/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit
import CoreData

class SearchTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    private var searchController = UISearchController(searchResultsController: UITableViewController())
    private var fetchedResultsController : NSFetchedResultsController?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        
        tableView.estimatedRowHeight = 50.0
        tableView.registerNib(UINib(nibName: "PhotoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoDetailTableViewCell")
        tableView.registerNib(UINib(nibName: "SearchHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHeaderTableViewCell")
        
        //Delete core data photos then fetch photos
        CoreDataManager.sharedInstance.deleteCoreDataPhotos() {
            WebServiceManager.sharedInstance.fetchPhotos({
                (controller, error) -> Void in
                self.fetchedResultsController = controller
                self.fetchedResultsController?.delegate = self
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    deinit {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func uploadPhoto() {
        showPhotoActionSheet()
    }
    
    // MARK: - Private Methods
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        navigationItem.titleView = searchController.searchBar
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.backgroundColor = .redColor()
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    // MARK: - UISearchBar Delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {

    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
 
    }
    
    // MARK: - UIImagePickerController Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        WebServiceManager.sharedInstance.savePhoto(image) {
            error -> Void in
            if error == nil {
                CoreDataManager.sharedInstance.deleteCoreDataPhotos() {
                    WebServiceManager.sharedInstance.fetchPhotos() {
                        (fetchedResultsController, error) -> Void in
                        if error == nil {
                            dispatch_async(dispatch_get_main_queue()) {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .System)
        button.backgroundColor = .darkGrayColor()
        button.setTitle("UPLOAD", forState: .Normal)
        button.addTarget(self, action: Selector("uploadPhoto"), forControlEvents: .TouchUpInside)
        return button
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let fetchedResultsController = fetchedResultsController {
            if let sections = fetchedResultsController.sections {
                return sections.count
            }
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fetchedResultsController = fetchedResultsController {
            let info = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
            return info.numberOfObjects
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoDetailTableViewCell", forIndexPath: indexPath) as! PhotoDetailTableViewCell
        
        if let fetchedResultsController = fetchedResultsController {
            let photo = fetchedResultsController.objectAtIndexPath(indexPath) as! Photo

            if let identifier = photo.imageIdentifier {
                cell.photo.setImageView(identifier)
            }
        }

        return cell
    }

}
