//
//  AdvImagesCollectionViewCell.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/8/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit

class AdvImagesCollectionViewCell:UICollectionViewCell {
    
    
    @IBOutlet weak var AdvImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    func SetModel(image:UIImage)
    {
        
        AdvImage.image = image
        
    }
    
}
