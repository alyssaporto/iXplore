//
//  PersistenceManager.swift
//  iXplore
//
//  Created by Alyssa Porto on 6/14/16.
//  Copyright © 2016 Alyssa Porto. All rights reserved.
//

import Foundation

class PersistenceManager {
    
    //Gets you the writing document directory path
    class func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory
    }
    
    class func loadObject(filename:String) -> NSObject? {
        let file = documentsDirectory().stringByAppendingPathComponent(filename)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSObject
    }
    
    class func saveObject(objectToSave: NSObject, fileName: String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(objectToSave, toFile: file)
    }
    
    class func saveNSArray(arrayToSave: NSArray, fileName:String) {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(arrayToSave, toFile: file)
    }
    
    class func loadNSArray(fileName:String) -> NSArray? {
        let file = documentsDirectory().stringByAppendingPathComponent(fileName)
        let result = NSKeyedUnarchiver.unarchiveObjectWithFile(file)
        return result as? NSArray
    }
}