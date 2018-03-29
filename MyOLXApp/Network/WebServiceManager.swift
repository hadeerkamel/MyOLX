//
//  WebServiceManager.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/11/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import  Alamofire
class WebServiceManager {
    
    func CreateHTTPRequest (uRL: String,
                            method: HTTPMethod,
                            parameters : Dictionary<String ,Any>?,
                            completionHnadller : @escaping ( _ httpREsponse: DataResponse<Any>)->()){
        let sessionManager = Alamofire.SessionManager.default
        
        let httpRequest = sessionManager.request (uRL, method: method, parameters: parameters)
        
        httpRequest.responseJSON{(response)in
            completionHnadller(response)
        }
    }
    
    func errorCodeHandler (errorCode : Int) -> String{
        
        switch errorCode {
        case 0:
            return "request successful"
        case -100:
            return "internal server error"
        case -101:
           return "required parameters not sent"
        case -102:
           return "email or password doesn’t match"
        case -103:
            return "email is already registered"
        default:
            return "Unknown Error"
        }
    } 
}
