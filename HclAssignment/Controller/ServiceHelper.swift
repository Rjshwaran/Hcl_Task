//
//  ServiceHelper.swift
//  HclAssignment
//
//  Created by admin on 10/08/20.
//  Copyright © 2020 admin. All rights reserved.
//


import UIKit


//@@ Base URL

let webApiBaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"

let timeoutInterval:Double = 45

enum loadingIndicatorType: CGFloat {
    case iLoader  = 0
    case withoutLoader  = 2
}

enum MethodType: CGFloat {
    case get  = 0
    case post  = 1
    case put  = 2
    case delete  = 3
    case patch  = 4
}

class ServiceHelper: NSObject {
    
    class func request(params: [String: Any],
                       method: MethodType,
                       apiName: String,
                       completionBlock: ((AnyObject?, Error?, Int)->())?) {
        
        let url = requestURL(method, apiName: apiName, parameterDict: params)
        
        var request = URLRequest(url: url)
        request.httpMethod = methodName(method)
        request.timeoutInterval = timeoutInterval
        
        let jsonData = body(method, parameterDict: params)
        request.httpBody = jsonData
        
        if method == .post  || method == .put || method == .patch {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.perform(hudType: .iLoader) { (responseObject: AnyObject?, error: Error?, httpResponse: HTTPURLResponse?) in
            
            guard let block = completionBlock else {
                return
            }
            
            DispatchQueue.main.async(execute: {
                guard let httpResponse = httpResponse else {
                    block(responseObject, error, 9999)
                    return
                }
                block(responseObject, error, httpResponse.statusCode)
            })
        }
    }
    
    //MARK:- Private Functions >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    class fileprivate func methodName(_ method: MethodType)-> String {
        
        switch method {
        case .get: return "GET"
        case .post: return "POST"
        case .delete: return "DELETE"
        case .put: return "PUT"
        case .patch: return "PATCH"
            
        }
    }
    
    class fileprivate func body(_ method: MethodType, parameterDict: [String: Any]) -> Data {
        
        switch method {
        case .post: fallthrough
        case .patch: fallthrough
        case .put: return parameterDict.toData()
        case .get: fallthrough
        default: return Data()
        }
    }
    
    class fileprivate func requestURL(_ method: MethodType, apiName: String, parameterDict: [String: Any]) -> URL {
        let urlString = webApiBaseURL + apiName
        
        switch method {
        case .get:
            return getURL(apiName, parameterDict: parameterDict)
            
        case .post: fallthrough
        case .put: fallthrough
        case .patch: fallthrough
            
        default: return URL(string: urlString)!
        }
    }
    
    class fileprivate func getURL(_ apiName: String, parameterDict: [String: Any]) -> URL {
        
        let urlString = webApiBaseURL + apiName
        
        let strUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string:strUrl!)!
    }
    
}

extension URLRequest  {
    
    func perform(hudType: loadingIndicatorType, completionBlock: @escaping (AnyObject?, Error?, HTTPURLResponse?) -> Void) -> Void {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: self, completionHandler: {
            (data, response, error) in
            if let error = error {
                completionBlock(nil, error, nil)
            } else {
                
                let httpResponse = response as! HTTPURLResponse
                let responseCode = httpResponse.statusCode
                let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    print("could not convert data to UTF-8 format")
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                    //Debug.log("\n\n result  >>>>>>\n\(result)")
                    completionBlock(result as AnyObject?, nil, httpResponse)
                } catch {
                    
                    completionBlock(nil, error, httpResponse)
                }
            }
        })
        
        task.resume()
    }
}


