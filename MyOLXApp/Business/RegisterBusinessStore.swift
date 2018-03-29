//
//  RegisterBusinessStore.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/11/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import Alamofire
import ObjectMapper

class RegisterBusinessSore {
    
    func RegisterWith(username : String , password : String , phone : String ,
                      email : String , address : String, lat : Double, lng : Double ,
                      compilationHandler : @escaping (_ registerModel : RegisterDataModel?)->()){
        
        let parameters   = ["username" : username, "password" : password , "phone" : phone ,
                          "email" : email , "address" : address, "lat" : lat, "lng" : lng ] as [String : Any]
        
        WebServiceManager().CreateHTTPRequest(uRL: "http://mahmoudtarek.info/olx/register.php", method: HTTPMethod.post , parameters: parameters ){(response) in
            if response.result.isSuccess {
                
                let registerModel = Mapper <RegisterDataModel>().map(JSONObject: response.result.value)
                compilationHandler(registerModel)
                
            }
            else{
                compilationHandler(nil)
            }
            
        }
        
    }
    
}
