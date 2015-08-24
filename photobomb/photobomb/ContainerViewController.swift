//
//  ContainerViewController.swift
//  photobomb
//
//  Created by BJ Griffin on 8/3/15.
//  Copyright © 2015 mojo. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: .Regular), forChildViewController: childViewControllers.last!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
