//
//  ImageModal.swift
//  HclAssignment
//
//  Created by admin on 10/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ImageModal: NSObject {
    
    //MARK: Properties
    var title = ""
    var imageDescription = ""
    var imageHref = ""
    var image: UIImage?

    //MARK: Class functions

    class func imageModal(_ object: Dictionary<String, AnyObject>) -> ImageModal {
        
        let modal = ImageModal()
        modal.title = object.stringForKey("title")
        modal.imageDescription = object.stringForKey("description")
        modal.imageHref = object.stringForKey("imageHref")

        return modal
    }
    
    class func imageModalList(_ array: Array<Dictionary<String, AnyObject>>) -> Array<ImageModal> {
        
        var list = [ImageModal]()
        for object in array {
            
            let modal = ImageModal.imageModal(object)
            // skip invalid data i.e. if there is no title and imageHref
            if modal.title.length == 0 && modal.imageHref.length == 0 {
                continue
            }
            list.append(modal)
        }
        
        return list
    }
}
