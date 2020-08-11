//
//  CoreImage+CoreDataClass.swift
//  
//
//  Created by admin on 10/08/20.
//
//

import Foundation
import CoreData

@objc(CoreImage)
public class CoreImage: NSManagedObject {

    class func saveImageDetails(countryInfo:ImageRowsDTO, title: String)
       {
           let imageDetails = CoreDataHandler().getEntity(entityName: "CoreImage") as! CoreImage
            
           imageDetails.name = countryInfo.title
           imageDetails.imageURL = countryInfo.image
           imageDetails.desc = countryInfo.description
          // countryDetails.navTitle = title
           CoreDataHandler().saveEntity(entity: imageDetails)
       }
}
