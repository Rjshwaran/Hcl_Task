//
//  GeneralExtensions.swift
//  HclAssignment
//
//  Created by admin on 10/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SDWebImage



// MARK:- Dictionary Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

extension Dictionary {
    
    func stringForKey(_ key: Key) -> String {
        if let string = self[key] as? String {
            return string
        }
        
        return ""
    }
    
    func toData() -> Data {
        return try! JSONSerialization.data(withJSONObject: self, options: [])
    }
    
    func toJsonString() -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        return jsonString
    }
}

// MARK:- UIImageView Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

extension UIImageView {
    
    func normalLoad(_ string: String) {
        
        if let url = URL(string: string) {
            self.sd_setImage(with: url, placeholderImage: UIImage(named: "noresponse")!)
            
            
            
        } else {
            self.image = UIImage(named: "noresponse")
        }
    }
}

// MARK:- String Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

extension String {
    var length: Int {
        return self.count
    }
}

// MARK:- UIView Extensions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

extension UIView {
    
    @IBInspectable var corner: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            
            self.layer.borderWidth = newValue
            self.clipsToBounds = true
        }
    }
}
