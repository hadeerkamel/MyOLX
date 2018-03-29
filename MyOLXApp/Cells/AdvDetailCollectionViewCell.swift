//
//  AdvDetailCollectionViewCell.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/16/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import Kingfisher
class AdvDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var advCellImage: UIImageView!
    
    func setImageURL(imageURL: String){
        
       advCellImage.kf.setImage(with: URL(string: imageURL))
    }
    
}
