//
//  AdvDetailsViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/16/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit

class AdvDetailsViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource {

    var advModel : AdvsModel!
    
    @IBOutlet weak var advImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var advPriceLabel: UILabel!
    
    @IBOutlet weak var advTitleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var posterNameLabel: UILabel!
    
    @IBOutlet weak var contactView: UIView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var contactButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializationn()
    }
    func initializationn(){
        contactView.isHidden = true
        
        //Model
        if(advModel != nil){
            advPriceLabel.text =  String(format:"%.2f" ,advModel.price!) + " EGP"
            advTitleLabel.text = advModel.title
            descriptionLabel.text = advModel.descriptoin_
            if advModel.poster != nil && advModel.poster?.email != nil && advModel.poster?.userName != nil{
            posterNameLabel.text = advModel.poster?.userName
            emailLabel.text = "Email : "+(advModel.poster?.email)!
            phoneLabel.text = "Phone : "+(advModel.poster?.phone)!
            }
            else{
                posterNameLabel.text = ""
                emailLabel.text = ""
                phoneLabel.text = ""
                
            }
            
        }
        contactButton.setShadow()
        
    }
    @IBAction func didTapLocationButton(_ sender: Any) {
        
        //go to Map View
        if (advModel.poster != nil && advModel.poster?.lat != nil){
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapViewController")as! GoogleMapViewController
        mapVC.lat = (advModel.poster?.lat)!
        mapVC.lng = (advModel.poster?.lng)!
        
        self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
    @IBAction func didTapContactButton(_ sender: Any) {
        contactView.isHidden = !contactView.isHidden
    }
    func setModel(model: AdvsModel){
        
        advModel = model
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return (advModel.images?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvDetailCollectionViewCell", for: indexPath)as! AdvDetailCollectionViewCell
        if(!(advModel.images?.isEmpty)!){
            cell.setImageURL(imageURL: (advModel.images?[indexPath.row])!)
        }
        
        return cell
    }
    
}
