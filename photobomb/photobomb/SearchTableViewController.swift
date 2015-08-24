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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("addPhotoWillDismiss:"), name: "AddPhotoWillDismiss", object: nil)
        
        setupSearchController()
        
        tableView.estimatedRowHeight = 50.0
        tableView.registerNib(UINib(nibName: "PhotoDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoDetailTableViewCell")
        
        //Delete core data photos then fetch photos
        CoreDataManager.sharedInstance.deleteCoreDataPhotos() {
            AppDataManager.sharedInstance.fetchPhotos({
                (controller, error) -> Void in
                self.fetchedResultsController = controller
                self.fetchedResultsController?.delegate = self
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    @IBAction func drawerAction(sender: AnyObject) {
        let splitViewContainerController = splitViewController?.parentViewController

        if splitViewController?.traitCollection.horizontalSizeClass == .Compact {
            splitViewContainerController?.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Regular), forChildViewController: splitViewController!)
        } else {
            splitViewContainerController?.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Compact), forChildViewController: splitViewController!)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "AddPhotoWillDismiss", object: nil)
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
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        let addPhotoNavigationViewController = UIViewController.getAddPhotoNavigationViewController()
        let addPhotoViewController = addPhotoNavigationViewController.viewControllers[0] as! AddPhotoViewController
        
        presentViewController(addPhotoNavigationViewController, animated: true, completion: {
            addPhotoViewController.photo?.image = image
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view delegate

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

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

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
    
    //MARK: NSNotificationCenter Methods
    
    func addPhotoWillDismiss(notification:NSNotification) {
        tableView.reloadData()
    }
}
