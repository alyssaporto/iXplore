//
//  Place.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/13/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation, NSCoding  {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String? = ""
    var imageURL: String? = ""
    var placeDescription: String? = ""
    var date: NSDate?
    var favorite:Bool = false
    
    required init(coordinate: CLLocationCoordinate2D, title: String, placeDescription: String, date: NSDate, favorite: Bool) {
        self.coordinate = coordinate
        self.title = title
        // self.imageURL = imageURL
        self.placeDescription = placeDescription
        self.date = date
        self.favorite = favorite
    }
        
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(Double(NSNumber(double: self.coordinate.latitude)), forKey: "latitude")
        aCoder.encodeObject(Double(NSNumber(double: self.coordinate.longitude)), forKey: "longitude")
        aCoder.encodeObject(self.title, forKey: "title")
//        aCoder.encodeObject(self.imageURL, forKey: "imageURL")
        aCoder.encodeObject(self.placeDescription, forKey: "placeDescription")
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeObject(self.favorite, forKey: "favorite")

    }
    
    required convenience init?(coder aDecoder: NSCoder) {
            
        let latitude = aDecoder.decodeObjectForKey("latitude") as? Double
        let longitude = aDecoder.decodeObjectForKey("longitude") as? Double
        let title = aDecoder.decodeObjectForKey("title") as? String
        let placeDescription = aDecoder.decodeObjectForKey("placeDescription") as? String
        let date = aDecoder.decodeObjectForKey("date") as? NSDate
        let favorite = aDecoder.decodeObjectForKey("favorite") as? Bool
        
        print(latitude)
        
        var decodeCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
        decodeCoordinate.latitude = latitude! as CLLocationDegrees
        decodeCoordinate.longitude = longitude! as CLLocationDegrees
        
        self.init(coordinate: decodeCoordinate, title: title!, placeDescription: placeDescription!, date: date!, favorite: false)

    }
    
//    class func placeList() -> [Place] {
//        
//        let spot = Place(coordinate: CLLocationCoordinate2D(latitude: -33.906764,longitude: 18.4164983), title: "Workshop 17", placeDescription: "", date: NSDate(), favorite: false)
//        spot.imageURL = "https://avatars1.githubusercontent.com/u/7220596?v=3&s=200"
//        
//        let spot2 = Place(coordinate: CLLocationCoordinate2D(latitude: -33.9281976,longitude: 18.4227045), title: "Truth Coffee", placeDescription: "", date: NSDate(), favorite: false)
//        spot2.imageURL = "https://robohash.org/123.png"
//        
//        let spot3 = Place(coordinate: CLLocationCoordinate2D(latitude: -33.9271879,longitude: 18.4327055), title: "Chop Chop Coffee", placeDescription: "", date: NSDate(), favorite: false)
//        spot.imageURL = "http://cdn3.ixperience.co.za/assets/icons/interview-step-2-801f63110f89e85e38f27d39f5864a1399f256fe0684844caea2a18c4b6fbd33.svg"
//        
//        // Add - Lions Head, Boulders Beach, V & A Market, Shark Cage Diving, Aquila Safari, Never@Home, Camps Bay, Waterfront Mall, Old Biscuit Mill, Classio Restaurant
//        
//        return [spot,spot2, spot3]
//        
//    }
    
}

extension UIImageView   {
    
    
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
    
}