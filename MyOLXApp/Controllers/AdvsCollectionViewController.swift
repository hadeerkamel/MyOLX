//
//  AdvsCollectionViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/11/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit

class AdvsCollectionViewController: BaseViewController ,UICollectionViewDelegate ,UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{

    @IBOutlet weak var AdvsCollectionView: UICollectionView!
    var advsList: [AdvsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        // Do any additional setup after loading the view.
    }
    func initialization(){
        
        AdvsCollectionView.register(UINib(nibName: "AdvCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdvCollectionViewCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !advsList.isEmpty{
            return advsList.count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (AdvsCollectionView.frame.width-10)/2
        let cellHeight = CGFloat(150)
        return CGSize(width : cellWidth , height : cellHeight)
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = AdvsCollectionView.dequeueReusableCell(withReuseIdentifier: "AdvCollectionViewCell", for: indexPath)as! AdvCollectionViewCell
        
            
        cell.setModel(model: advsList[indexPath.row])
       
        
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "AdvDetailsViewController")as! AdvDetailsViewController
        targetVC.setModel(model: advsList[indexPath.row])
        self.navigationController?.pushViewController(targetVC, animated: true)
        //present Adv deteles view controller
    }
    
    func setModel(advs: [AdvsModel]){
        advsList = advs
    }
}
