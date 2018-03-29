//
//  RegisterViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/6/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import GoogleMaps

class RegisterViewController: UIViewController ,CLLocationManagerDelegate{
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor=UIColor.white
        self.navigationController?.navigationBar.topItem?.title="Login"
              
        Initilaization()
    }

    func Initilaization(){
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
                    }
        registerButton.setRadious(radious: 10)
        registerButton.setShadow()
        
    }
    @IBAction func didFinishEditingRepeatPassword(_ sender: Any) {
        if passwordTextField.text != repeatPasswordTextField.text{
            repeatPasswordTextField.textColor = UIColor.red
            repeatPasswordTextField.text = " Password Doesn't Match !!!"
        }
    }

    @IBAction func didBeginEditing(_ sender: Any) {
        repeatPasswordTextField.textColor = UIColor.black
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        
    RegisterBusinessSore().RegisterWith(username: usernameTextField.text!,
                                        password: passwordTextField.text!,
                                        phone: phoneTextField.text!,
                                        email: emailTextField.text!,
                                        address: addressTextField.text!,
                                        lat: (locationManager.location?.coordinate.latitude)!,
                                        lng: (locationManager.location?.coordinate.longitude)!){(registerModel) in
                                            
            if registerModel?.errorCode != nil {
                
                if registerModel?.errorCode == 0{
                    self.resultLabel.textColor = UIColor.green
                    self.resultLabel.text = "registration successed"
                    //Act as Logedin
                    AuthenticationBusinessStore().loginWith(email: self.emailTextField.text!, passowrd: self.passwordTextField.text!){(loginModel) in
                        if loginModel?.errorCode != nil && loginModel?.errorCode == 0{
                        LoginViewController().saveLoginDataAndBack(loginModel: loginModel!)
                        }
                    }
                }else{
                    self.resultLabel.text =  WebServiceManager().errorCodeHandler(errorCode: (registerModel?.errorCode)!)
                }
                
            }
            else{
                self.resultLabel.text =  "connection error"
            }
        }
    }
   

}
