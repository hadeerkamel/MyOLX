//
//  RegisterDataModel.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/11/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import ObjectMapper

class RegisterDataModel : Mappable{
    
    var errorCode : Int?
    
    required init(map : Map){
        
    }
    func mapping (map : Map){
        errorCode <- map["errorCode"]
    }
}
