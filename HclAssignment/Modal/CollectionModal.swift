//
//  CollectionModal.swift
//  HclAssignment
//
//  Created by admin on 10/08/20.
//  Copyright © 2020 admin. All rights reserved.
//


import UIKit

class CollectionModal: NSObject {

    //MARK: Properties
    var title: String
    var rows: Array<ImageModal>

    //MARK: Init
    init(text: String) {
        title = text
        rows = []
    }
    
    convenience init(object: Dictionary<String, AnyObject>) {
        self.init(text: object.stringForKey("title"))

        if let rows = object["rows"] as? Array<Dictionary<String, AnyObject>> {
            self.rows = ImageModal.imageModalList(rows)
        }
     }
}
