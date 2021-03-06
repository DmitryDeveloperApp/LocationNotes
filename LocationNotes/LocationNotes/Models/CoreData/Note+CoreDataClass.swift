//
//  Note+CoreDataClass.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 30.05.2022.
//
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {

    class func newNote(name: String, inFolder: Folder?) -> Note {
      let newNote = Note(context: CoreDataManager.sharedInstance.managetObjectContext)
        
        newNote.name = name
        newNote.dataUpdate = Date()
        
       // if let inFolder = inFolder {
            newNote.folder = inFolder
       // }
        
        return newNote
    }
    
    var imageActual: UIImage? {
        set {
            if newValue == nil {
                if self.image != nil {
                    CoreDataManager.sharedInstance.managetObjectContext.delete(self.image!)
                }
                self.imageSmall = nil
            }else {
                if self.image == nil {
                    self.image = ImageNote(context: CoreDataManager.sharedInstance.managetObjectContext)
                    
                }
                self.imageSmall = newValue!.jpegData(compressionQuality: 0.05) as Data?
                self.image?.imageBig = newValue!.jpegData(compressionQuality: 1) as Data?
            }
            dataUpdate = Date()
        }
        get {
            if self.image != nil {
                if image?.imageBig != nil {
                    return UIImage(data: (self.image?.imageBig)! as Data)
                }
            }
            return nil
        }
    }
    
    var locationActual : LocationCoordinate? {
        get {
            if self.location == nil {
                return nil
            } else {
                return LocationCoordinate(lat: self.location!.lot, lon: self.location!.lon)
            }
        }
        
        set {
            if newValue == nil && self.location != nil {
                //delete location
                CoreDataManager.sharedInstance.managetObjectContext.delete(self.location!)
            }
            if newValue != nil && self.location != nil {
                // reload location
                self.location?.lot = newValue!.lat
                self.location?.lon = newValue!.lon
            }
            if newValue != nil && self.location == nil {
                // create location
                let newLocation = Location(context: CoreDataManager.sharedInstance.managetObjectContext)
                newLocation.lot = newValue!.lat
                newLocation.lon = newValue!.lon
                self.location = newLocation
            }
        }
    }
    
    func addCurrentLocation() {
        LocationManager.sharedInstance.getCurrentLocation { (location) in
            self.locationActual = location
           print("Get new location \(location)")
        }
    }
    
    func addImage(image: UIImage) {
      let imageNote = ImageNote(context: CoreDataManager.sharedInstance.managetObjectContext)
      
        imageNote.imageBig = image.jpegData(compressionQuality: 1)
        self.image = imageNote
    }
    
    func addLocation(latitude: Double, lontitude: Double) {
       let location =  Location(context: CoreDataManager.sharedInstance.managetObjectContext)
        
        location.lot = latitude
        location.lon = lontitude
        self.location = location
    }
    
    var dateUpdateString: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: self.dataUpdate!)
    }
    
}
