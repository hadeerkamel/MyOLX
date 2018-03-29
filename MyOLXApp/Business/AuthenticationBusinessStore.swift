//
//  AuthenticationBusinessStore.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/11/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import Alamofire
import ObjectMapper
class AuthenticationBusinessStore {
    
    func loginWith(email: String ,passowrd :String , completionHandler: @escaping (_ loginModel: LoginDataModel?)->()){
        WebServiceManager().CreateHTTPRequest(uRL: "http://mahmoudtarek.info/olx/login.php", method: HTTPMethod.post, parameters: ["email":email ,"password":passowrd]) { (response) in
            
            print(response.debugDescription)
            
            if response.result.isSuccess
            {
                let loginModel = Mapper<LoginDataModel>().map(JSONObject: response.result.value)
                completionHandler(loginModel)
            }
            else{
                completionHandler(nil)
            }
        
        }
    }
    
    
    
}
