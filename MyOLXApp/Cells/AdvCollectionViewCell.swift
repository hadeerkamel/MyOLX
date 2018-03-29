//
//  AdvCollectionViewCell.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/11/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class AdvCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoritButton: UIButton!
    
    @IBOutlet weak var AdvImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var advModel: AdvsModel!
    
    var isFavorit = false

    let appDelegete = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        context = appDelegete.persistentContainer.viewContext
        
        
        // Initialization code
    }
    func SetFavoritState (){
        if !isFavorit {
            favoritButton.setImage(UIImage (named : "BlueStar" ) , for: .normal)
            //save to dataBase
            saveAdv(context: context, appDelegate: appDelegete, state: "Favorits", advID: Int32(advModel.id!), advCategoryID: Int32(advModel.categoryId!))
            let favCount = UserDefaults.standard.integer(forKey: "Favorits")
             UserDefaults.standard.set(favCount+1, forKey: "Favorits")
            //increase user defaults count
        }
        else{
            favoritButton.setImage(UIImage(named : "Favorits"), for: .normal)
            //remove from dataBase
           
            do{
                let request: NSFetchRequest<AdvsData
                    > = AdvsData.fetchRequest()
                request.predicate = NSPredicate(format: "(advType == %@) AND (advCategoryID == %d) AND (advID == %d)","Favorits",advModel.categoryId!,advModel.id!)
                let savedAdv = try context.fetch(request)
                for object in savedAdv{
                context.delete(object)
                }
                appDelegete.saveContext()
                let favCount = UserDefaults.standard.integer(forKey: "Favorits")
                UserDefaults.standard.set(favCount-1, forKey: "Favorits")
               // savedAdvs = try context.fetch()
                //savedAdvs.s
                
            }catch{
                print(error)
                
            }
            
            //decrease user defaults count
            
        }
        
        isFavorit = !isFavorit
    }
    
    @IBAction func didTappedFavoritButton(_ sender: Any) {
        SetFavoritState()
    }
    func setModel(model: AdvsModel){
        advModel = model
        if(advModel.images?.count != 0){
        AdvImage.kf.setImage(with: URL(string: (advModel.images?[0])!))
        }
        titleLabel.text = advModel.title
        priceLabel.text = String(format:"%.2f",advModel.price!)
        do{
            let request: NSFetchRequest<AdvsData
                > = AdvsData.fetchRequest()
            request.predicate = NSPredicate(format: "(advType == %@) AND (advCategoryID == %d) AND (advID == %d)","Favorits",advModel.categoryId!,advModel.id!)
            let savedAdv = try context.fetch(request)
            if savedAdv.count != 0{
                favoritButton.setImage(UIImage (named : "BlueStar" ) , for: .normal)
                isFavorit = !isFavorit
            }
        }catch{
            print(error)
        }
    }

}
