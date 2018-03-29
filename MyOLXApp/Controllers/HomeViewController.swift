//
//  HomeViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/6/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var adsCategoriesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryIds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = adsCategoriesTableView.dequeueReusableCell(withIdentifier: "advCategoryTableViewCell", for: indexPath)as! advCategoryTableViewCell
        cell.setModel(categoryId: indexPath.row)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var catID : Int?
         catID = indexPath.row
        if catID == 0{
            catID = nil
        }
        AdvsBusinessStore().getAdvs(categoryId: catID){(advsModel) in
            
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
            
            
        }
    }
    

    

}
