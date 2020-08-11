//
//  CoreImage+CoreDataProperties.swift
//  
//
//  Created by admin on 10/08/20.
//
//

import Foundation
import CoreData


extension CoreImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreImage> {
        return NSFetchRequest<CoreImage>(entityName: "CoreImage")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var imageURL: String?

}
