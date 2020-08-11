//
//  ImageDTO.swift
//  Assignment
//
//  Created by C02VG1PAG8WN on 09/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class ImageDTO {
    var countryTitle: String?
    var imageRows : [ImageRowsDTO] =  [ImageRowsDTO]()
}

class ImageRowsDTO {
    var title : String?
    var description: String?
    var image: String?
}
