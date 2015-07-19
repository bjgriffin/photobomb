//
//  AppDelegate.swift
//  photobomb
//
//  Created by Bethurel Griffin Jr on 6/17/15.
//  Copyright (c) 2015 mojo. All rights reserved.
//

import UIKit
import Bolts
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("Nq2JvWFP2bLpMxzBPg2mfeHnO5SR8DlG0OR0drnv",
            clientKey: "twhLjKfW6HFTJOGkHFPVZ2SyUPRPwZ5p3fygJObe")
        
        setupTabBarController()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK: Private Methods
    
    /**
    Setup for initial view controllers at launch
    
    */
    private func setupTabBarController() {
        let navigationController = self.window!.rootViewController as! UINavigationController
        let tabBarController = navigationController.topViewController as! UITabBarController
        let navigationController1 = tabBarController.viewControllers?[0] as! UINavigationController
        navigationController1.setViewControllers([UIViewController.getSearchViewController()], animated: false)
        
        let navigationController2 = tabBarController.viewControllers?[1] as! UINavigationController
        navigationController2.setViewControllers([UIViewController.getLoginViewController()], animated: false)
    }

}

