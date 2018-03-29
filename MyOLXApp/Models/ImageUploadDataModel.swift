//
//  ImageUploadDataModel.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/13/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import ObjectMapper

class ImageUploadDataModel: Mappable{
    var errorCode : Int?
    var imageId : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        errorCode <- map["errorCode"]
        imageId <- map["image_id"]
    }
}
