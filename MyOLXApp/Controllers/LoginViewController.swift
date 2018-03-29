//
//  LoginViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/6/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController{

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    let appDelegate  = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    
    @IBOutlet weak var LogInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = appDelegate.persistentContainer.viewContext
        self.navigationController?.navigationBar.tintColor=UIColor.white
        
        initialize()
    }

    func initialize(){
        
        LogInButton.setRadious(radious: 10)
        LogInButton.setShadow()
        userEmailTextField.setBorders(width: 1, color: UIColor.lightGray)
        userPasswordTextField.setBorders(width: 1, color: UIColor.lightGray)
        userEmailTextField.setRadious(radious: 10)
        userPasswordTextField.setRadious(radious: 10)

    }
    
    @IBAction func didTappedLoginButton(_ sender: Any) {
        resultLabel.text = ""
        AuthenticationBusinessStore().loginWith(email: userEmailTextField.text!, passowrd: userPasswordTextField.text!){ (loginModel)in
            
            if loginModel?.errorCode != nil  {
                
                if loginModel?.errorCode == 0 {
                    //Logedin
                    //Save User Data
                    //Back from navigator
                    
                    self.saveLoginDataAndBack(loginModel: loginModel! )
                  
                    
                }
                else{
                    self.resultLabel.text = WebServiceManager().errorCodeHandler(errorCode: (loginModel?.errorCode)!)
                }
                
            } else {
                
                self.resultLabel.text = "Connection Error"
                
            }

        }
    }
        
    func saveLoginDataAndBack(loginModel : LoginDataModel){
        
        UserDefaults.standard.set(true, forKey: "isLoged")
        
        let item = LogedUserDataModel (context: context)
        
      
        item.username = loginModel.data?.userName
        item.email = loginModel.data?.email
        item.address = loginModel.data?.address
        item.phone = loginModel.data?.phone
        item.password = loginModel.data?.password
        item.lat = (loginModel.data?.lat!)!
        item.lng = (loginModel.data?.lng!)!
        item.id = (loginModel.data?.id!)!
        
        appDelegate.saveContext()
          BaseViewController().loadLogedUserData(context_: context)
        _ = navigationController?.popViewController(animated: true)
        
    }

}
