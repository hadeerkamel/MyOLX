//
//  UIButtonExtention.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/21/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//
import UIKit

extension UIButton {
    
    func setRadious (radious: CGFloat){
        layer.cornerRadius = radious
        clipsToBounds = true
        
       
    }
    func setShadow (){
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }
}
