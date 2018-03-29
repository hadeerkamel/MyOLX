//
//  LoginDataModel.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/11/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginDataModel: Mappable {
    var errorCode : Int?
    var data: UserModel?

required init?(map: Map){
    
}
    func mapping(map: Map) {
        errorCode <- map["errorCode"]
        data <- map["data"]
    }
    
}
class UserModel: Mappable {
    
    var id : Int32?
    var userName : String?
    var email : String?
    var phone : String?
    var address : String?
    var lat : Double?
    var lng : Double?
    var password : String?
    
    required init?(map: Map) {
        
    }
     func mapping(map: Map) {
        
        id <- (map["id"], TransformOf<Int32, String>(fromJSON: { Int32($0!) }, toJSON: { $0.map { String($0) } }))
        userName <- map["username"]
        email <- map["email"]
        phone <- map["phone"]
        address <- map["address"]
        lat <- (map["lat"] , TransformOf<Double, String>(fromJSON: { Double($0!) }, toJSON: { $0.map { String($0) } }))
        lng <- (map["lng"], TransformOf<Double, String>(fromJSON: { Double($0!) }, toJSON: { $0.map { String($0) } }))
        
        password <- map["password"]
        
    }
    
}
