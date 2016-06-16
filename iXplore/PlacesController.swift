//
//  PlacesController.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/14/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import Foundation
import MapKit

class PlacesController {
    
    var placeArray: [Place] = []
    
    class var sharedInstance: PlacesController {
        struct Static {
            static var instance:PlacesController?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)    {
            Static.instance = PlacesController()
        }
        return Static.instance!
    }
    
    func addPlace(coordinate: CLLocationCoordinate2D, title: String, placeDescription: String, date: NSDate, favorite: Bool) {
        let newPlace = Place(coordinate: coordinate, title: title, placeDescription: placeDescription, date: date, favorite: favorite)
        placeArray.append(newPlace)
        saveArray()

    }
    
    private func readPlacesFromMemory() -> [Place] {
        let places = PersistenceManager.loadNSArray("array") as! [Place]
        return places
    }
 
    func getPlaces() -> [Place] {
        if placeArray.isEmpty {
            placeArray = readPlacesFromMemory()
            if placeArray.isEmpty {
                placeArray = Place.placeList()
            }
        }
        return placeArray
    }
    
    func saveArray() {
        PersistenceManager.saveNSArray(placeArray, fileName: "array")
        
    }
    
}
