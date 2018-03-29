//
//  advCategoryTableViewCell.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/13/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit

class advCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setModel(categoryId: Int){
        categoryLabel.text = categoryNames[categoryId]
    }

}
