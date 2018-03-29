//
//  AddAdvBusinessStore.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/13/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import Alamofire
import ObjectMapper
class AddAdvBusinessStore {
    func postAdv(title: String,
                 description: String,
                 price: Float,
                 images: [Int],
                 posterID: Int,
                 categoryID: Int ,completionHandler: @escaping (_ advModel:AddAdvDataModel?)->()){
        
        WebServiceManager().CreateHTTPRequest(uRL: "http://mahmoudtarek.info/olx/addadv.php",
                                              method: HTTPMethod.post, parameters: ["title":title,"description":description,"price":price,"images":images,"posterID":posterID,"categoryID":categoryID]){(response) in
            print(response.debugDescription)
                       if response.result.isSuccess{
                let advModel = Mapper<AddAdvDataModel>().map(JSONObject: response.result.value)
                completionHandler(advModel)
            }
            else{
                completionHandler(nil)
            }
            
        }
        
    }
}
