//
//  SearchViewController.swift
//  photobomb
//
//  Created by BJ Griffin on 7/17/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBarContainer: UIView!
    @IBOutlet weak var containerLayoutConstraint: NSLayoutConstraint!
    private var searchController = UISearchController(searchResultsController: UITableViewController())
    
    
    override func viewDidAppear(animated: Bool) {
        searchController.searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        UIView.animateWithDuration(1.0, animations: {
            self.containerLayoutConstraint.constant = 0
            self.view.layoutIfNeeded()
            }, completion: {(animated) -> Void in })
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        UIView.animateWithDuration(1.0, animations: {
            self.containerLayoutConstraint.constant = 200
            self.view.layoutIfNeeded()
            }, completion: {(animated) -> Void in })
    }
}
