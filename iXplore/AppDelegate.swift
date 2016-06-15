 //
//  AppDelegate.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/13/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    var locationStatus:String?
    var locationManager: CLLocationManager = CLLocationManager()
    //var currentLocation

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let landingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
        self.navigationController = UINavigationController(rootViewController: landingViewController)
                
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = self.navigationController
        self.navigationController?.navigationBarHidden = false
        
        locationManager.startUpdatingLocation()
        print("\(locationManager.location)")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Override point for customization after application launch.
        return true
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        switch status {
        case CLAuthorizationStatus.Restricted:
            print("Restricted Access to location")
        case CLAuthorizationStatus.Denied:
            print("Denied Access to location")
        case CLAuthorizationStatus.NotDetermined:
            print("Status not determined")
        default:
            print("Allows to access location")
            shouldIAllow = true
    
        }
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


}

