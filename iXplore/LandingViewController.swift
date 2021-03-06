//
//  LandingViewController.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/13/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LandingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationManager.startUpdatingLocation()
        PlacesController.sharedInstance.getPlaces()
        
        setupMapView()
        setupTableView()
        self.mapView.delegate = self
        appDelegate.locationManager!.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        let lvc = LandingViewController(nibName: "LandingViewController", bundle: nil)
        lvc.mapView.setRegion(region, animated: true)
        appDelegate.locationManager!.stopUpdatingLocation()
        lvc.mapView.showsUserLocation = true
    }
    
    func setupMapView() {
        mapView.mapType = .Hybrid
        mapView.addAnnotations(PlacesController.sharedInstance.placeArray)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(SpotTableViewCell.self, forCellReuseIdentifier: "SpotTableViewCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlacesController.sharedInstance.placeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let spot = PlacesController.sharedInstance.placeArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SpotTableViewCell", forIndexPath: indexPath) as! SpotTableViewCell
        cell.cellLabel.text = spot.title!
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let dateString = formatter.stringFromDate(spot.date!)
        cell.dateLabel.text = String(dateString)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let spot = PlacesController.sharedInstance.placeArray[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterAfterMove = CLLocationCoordinate2D(latitude: PlacesController.sharedInstance.placeArray[indexPath.row].coordinate.latitude, longitude: PlacesController.sharedInstance.placeArray[indexPath.row].coordinate.longitude)
        mapView.selectAnnotation(spot as MKAnnotation, animated: true)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: mapCenterAfterMove, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let favoriteAction = UITableViewRowAction(style: .Normal, title: "Favorite") { action, index in
            if PlacesController.sharedInstance.placeArray[indexPath.row].favorite == false {
                self.mapView.removeAnnotation(PlacesController.sharedInstance.placeArray[indexPath.row])
                PlacesController.sharedInstance.placeArray[indexPath.row].favorite = true
                self.mapView.addAnnotation(PlacesController.sharedInstance.placeArray[indexPath.row])
                PlacesController.sharedInstance.saveArray()
            } else {
                self.mapView.removeAnnotation(PlacesController.sharedInstance.placeArray[indexPath.row])
                PlacesController.sharedInstance.placeArray[indexPath.row].favorite = false
                self.mapView.addAnnotation(PlacesController.sharedInstance.placeArray[indexPath.row])
                PlacesController.sharedInstance.saveArray()
            }
        }
        favoriteAction.backgroundColor = UIColor.orangeColor()
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: " Delete ") { action, index in
            
            let alertController = UIAlertController(title: "Are you sure you want to delete \(PlacesController.sharedInstance.placeArray[indexPath.row].title!)?", message: "You will no longer be able to access this location if you choose to", preferredStyle: .Alert)
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
            alertController.addAction(cancelButton)
            
            let deleteButton = UIAlertAction(title: "Delete", style: .Default) { (action) in
                self.mapView.removeAnnotation(PlacesController.sharedInstance.placeArray[indexPath.row])
                PlacesController.sharedInstance.placeArray.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                PlacesController.sharedInstance.saveArray()
            }
            alertController.addAction(deleteButton)

            self.presentViewController(alertController, animated: true) {}
        }
        deleteAction.backgroundColor = UIColor.redColor()
        
        
        return [favoriteAction, deleteAction]
    }

    
    func mapView(mapView: MKMapView,
                 viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let anView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        if (annotation as! Place).favorite {
            anView.pinTintColor = UIColor.yellowColor()
        } else {
            anView.pinTintColor = UIColor.redColor()
        }
        anView.canShowCallout = true
        anView.animatesDrop = true
        return anView
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        
        let plusButton : UIBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LandingViewController.openModal))
        self.navigationItem.rightBarButtonItem = plusButton
        
        let logOutButton : UIBarButtonItem = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LandingViewController.logOutButtonTapped))
        self.navigationItem.leftBarButtonItem = logOutButton
        
        PlacesController.sharedInstance.getPlaces()
        setupMapView()
        setupTableView()
        tableView.reloadData()
    }
    
    func logOutButtonTapped() {
        appDelegate.navigateToLogOutNavigationController()
    }
    
    func openModal() {
        let newPlaceViewController = NewPlaceViewController(nibName: "NewPlaceViewController", bundle: nil)
        self.presentViewController(newPlaceViewController, animated: true, completion: nil)
        
    }
    
}
