//
//  AdvsBusinessStore.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/13/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import Alamofire
import ObjectMapper
class  AdvsBusinessStore{
    func getAdvs(categoryId: Int?,completionHandler: @escaping (_ adsModel: AdsDataModel?)->()){
        
        var param: Dictionary<String,Any>?
        if categoryId == nil{
            param=[:]
        }
        else{
            param = ["categoryID": categoryId! ]
        }
        WebServiceManager().CreateHTTPRequest(uRL: "http://mahmoudtarek.info/olx/advertisements.php", method: HTTPMethod.get, parameters: param){(response) in
            
            print(response.debugDescription)
            
            if response.result.isSuccess{
                let adsModel = Mapper<AdsDataModel>().map(JSONObject: response.result.value)
                completionHandler(adsModel)
            }
            else{
                completionHandler(nil)
            }
        }
        
    }
}
