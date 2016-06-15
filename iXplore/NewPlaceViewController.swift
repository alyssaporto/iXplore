//
//  NewPlaceViewController.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/14/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewPlaceViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let currentLocation = appDelegate.locationManager.location
        let currentLatitude = appDelegate.locationManager.location!.coordinate.latitude
        let currentLongitude = appDelegate.locationManager.location!.coordinate.longitude
        latitudeField.text = String(currentLatitude)
        longitudeField.text = String(currentLongitude)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        var coord: CLLocationCoordinate2D = CLLocationCoordinate2D()
        coord.latitude = CLLocationDegrees(Double(latitudeField.text!)!)
        coord.longitude = CLLocationDegrees(Double(longitudeField.text!)!)
        let placeTitle = titleField.text!
        let placeDescription = descriptionField.text!
        PlacesController.sharedInstance.addPlace(coord, title: placeTitle, placeDescription: placeDescription, date: NSDate(), favorite: false)
        
        PlacesController.sharedInstance.getPlaces()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
