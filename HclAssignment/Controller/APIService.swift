////
////  APIservice.swift
////  HclAssignment
////
////  Created by admin on 10/08/20.
////  Copyright © 2020 admin. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class APIService: NSObject {
//    
//    lazy var endPoint: String = {
//        return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
//    }()
//    
//   // https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json
//
//    func getDataWith(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
//        
//        let urlString = endPoint
//        
//        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update your feed")) }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//         guard error == nil else { return completion(.Error(error!.localizedDescription)) }
//            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
//}
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
//                    guard let itemsJsonArray = json["rows"] as? [[String: AnyObject]] else {
//                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
//                    }
//                    DispatchQueue.main.async {
//                        completion(.Success(itemsJsonArray))
//                    }
//                }
//            } catch let error {
//                return completion(.Error(error.localizedDescription))
//            }
//            }.resume()
//    }
//}
//
//enum Result<T> {
//    case Success(T)
//    case Error(String)
//}
//
//
//
//
//
