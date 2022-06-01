//
//  Folder+CoreDataClass.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 30.05.2022.
//
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {

    class func newFolder(name: String) -> Folder {
        let folder = Folder(context: CoreDataManager.sharedInstance.managetObjectContext)
        folder.name = name
        folder.dataUpdate = Date()
        return folder
    }
    
    func addNote() -> Note {
        let newNote = Note(context: CoreDataManager.sharedInstance.managetObjectContext)
          
        newNote.folder = self
        newNote.dataUpdate = Date()
        return newNote
    }
    
    var notesSorted: [Note] {
        let sortDescription = NSSortDescriptor(key: "dataUpdate", ascending: false)
       return self.notes?.sortedArray(using: [sortDescription]) as! [Note]
        
    }
    
}
