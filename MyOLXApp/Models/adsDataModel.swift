//
//  adsDataModel.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/13/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import ObjectMapper
class AdsDataModel: Mappable {
    var errorCode: Int?
    var advs: [AdvsModel]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        errorCode <- map["errorCode"]
        advs <- map["advs"]
        
    }
    
}
class AdvsModel: Mappable{
    var id: Int?
    var title: String?
    var descriptoin_: String?
    var price: Double?
    var categoryId: Int?
    var poster: UserModel?
    var images: [String]?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        id <- (map ["id"],TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        title <- map["title"]
        descriptoin_ <- map["description"]
        price <- (map["price"],TransformOf<Double, String>(fromJSON: { Double($0!) }, toJSON: { $0.map { String($0) } }))
        categoryId <- (map["category_id"],TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        poster <- map["poster"]
        images <- map["images"]
    }
    
}
