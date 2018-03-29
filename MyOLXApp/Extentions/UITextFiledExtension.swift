//
//  UITextFiledExtension.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/21/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
extension UITextField{
    func setBorders (width: CGFloat , color: UIColor){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.opacity = 0.5
    }
    func setRadious (radious: CGFloat){
        layer.cornerRadius = radious
        clipsToBounds = true
        
        
    }
    
}
