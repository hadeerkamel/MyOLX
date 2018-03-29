
//
//  Search.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/14/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import Alamofire
import ObjectMapper
class SearchBusenissStore{
    
    func searchWithKeyWord(query: String,completionHandler: @escaping (_ adsModel: AdsDataModel?)->()){
        
        WebServiceManager().CreateHTTPRequest(uRL: "http://mahmoudtarek.info/olx/search.php", method: HTTPMethod.get, parameters: ["query": query]){(response) in
            
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
