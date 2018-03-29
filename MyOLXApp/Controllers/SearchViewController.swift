//
//  SearchViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/14/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.setBorders(width: 0.5, color: UIColor.blue)
        searchTextField.setRadious(radious: 15)
        // Do any additional setup after loading the view.
    }

   
    @IBAction func didTapSearchButton(_ sender: Any) {
        
        SearchBusenissStore().searchWithKeyWord(query: searchTextField.text!){(advsModel) in
            
            if advsModel?.errorCode != nil{
                
                if advsModel?.errorCode == 0{
                    //creat advcollectionvc
                    //setModel -> send the advs
                    //present
                    
                    let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "AdvsCollectionViewController") as! AdvsCollectionViewController
                    
                    targetVC.setModel(advs: (advsModel?.advs)!)
                    
                    self.navigationController?.pushViewController(targetVC, animated: true)
                    
                }
            }
            else{
                print("connection error")
            }
            
            
        }    }
   
    

}
