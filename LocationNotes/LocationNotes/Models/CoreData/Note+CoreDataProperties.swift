//
//  Note+CoreDataProperties.swift
//  LocationNotes
//
//  Created by Dmitry Suprun on 30.05.2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var textDescription: String?
    @NSManaged public var imageSmall: Data?
    @NSManaged public var dataUpdate: Date?
    @NSManaged public var folder: Folder?
    @NSManaged public var location: Location?
    @NSManaged public var image: ImageNote?

}

extension Note : Identifiable {

}
