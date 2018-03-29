//
//  UploadImageBusinessStore.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/13/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import ObjectMapper
import Alamofire

class UploadImageBusinessStore {
    func uploadImage (imageString: String ,completionHandler :@escaping (_ imageModel:ImageUploadDataModel?)->()){
        
        WebServiceManager().CreateHTTPRequest(uRL:"http://mahmoudtarek.info/olx/upload_image.php",
                                              method: HTTPMethod.post,
                                              parameters: ["image" : imageString]){(response) in
            
             print(response.debugDescription)
            if response.result.isSuccess{
                let imageModel = Mapper<ImageUploadDataModel>().map(JSONObject: response.result.value)
                completionHandler(imageModel)
            }
            else{
                completionHandler(nil)
            }
            
        }
        
    
    }
}
