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

    class func newNote(name: String) -> Note {
      let newNote = Note(context: CoreDataManager.sharedInstance.managetObjectContext)
        
        newNote.name = name
        newNote.dataUpdate = Date()
        
        return newNote
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
    
    
}
