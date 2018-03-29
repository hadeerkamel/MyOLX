//
//  AddAdvViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/8/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import CoreData

class AddAdvViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    var advImages:  [UIImage ] = [UIImage]()
    var advImagesIds: [Int] = [Int]()
    var imagePicker = UIImagePickerController()
    var imagesLessThan8 = true
    
    var posterID: Int32!
    //var categoryIds: [String: Int] = [:]
    
    @IBOutlet weak var advTitleTextfield: UITextField!
    
    @IBOutlet weak var advCategoryNameTexField: UITextField!
    
    @IBOutlet weak var advDescriptionTextView: UITextView!
    
    @IBOutlet weak var advPriceTextField: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Intializations()
        
    }
    func Intializations(){
        
        advImages.append(UIImage(named : "AddPhoto")!)
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        /*if UserDefaults.standard.bool(forKey: "isLoged"){
            posterID = logedUserData[0].id
            //LoaduserData()
        }
        else {
            alarmForUnLogedUser()
        //    alarm for login , cancel -> pop , Login push login
        }*/
        context = appDelegate.persistentContainer.viewContext
        
        submitButton.setRadious(radious: 10)
        submitButton.setShadow()
        advTitleTextfield.setBorders(width: 1, color: UIColor.lightGray
        )
        advCategoryNameTexField.setBorders(width: 1, color: UIColor.lightGray
        )
        advPriceTextField.setBorders(width: 1, color: UIColor.lightGray
        )
        
        advTitleTextfield.setRadious(radious: 10)
        advCategoryNameTexField.setRadious(radious: 10)
        advPriceTextField.setRadious(radious: 10)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "isLoged"){
            posterID = logedUserData[0].id
            //LoaduserData()
        }
        else {
            alarmForUnLogedUser()
            //    alarm for login , cancel -> pop , Login push login
        }
        
    }
    
    
    @IBAction func didTapSubmitButton(_ sender: Any) {
        
        //loop on images , and upload them , get ids
        
        if imagesLessThan8{
            advImages.remove(at: 0)
        }
        
        var imageIndex=0
        for image in advImages{
            //convert
            imageIndex = imageIndex+1
            let imageData = UIImageJPEGRepresentation(image, 0)!
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            //uploadImageStore
            UploadImageBusinessStore().uploadImage(imageString: strBase64){(imageModel) in
                if imageModel?.errorCode != nil {
                    if imageModel?.errorCode == 0{
                        self.advImagesIds.append((imageModel?.imageId)!)
                        
                        
                        if imageIndex == (self.advImages.count){
                            self.postAdv()
                            
                        }
                        
                    }
                }
                else{
                    print("Connectoin Error")
                }
            }
        }
    }


        
        

    
    func postAdv(){
        
        if !advImagesIds.isEmpty{
            
            AddAdvBusinessStore().postAdv(title: (advTitleTextfield?.text)!, description: advDescriptionTextView.text, price: Float(advPriceTextField.text!)!, images: advImagesIds, posterID: Int(posterID), categoryID: categoryIds[advCategoryNameTexField.text!]!){(addadvModel)in
                
                if addadvModel?.errorCode != nil{
                    if addadvModel?.errorCode == 0{
                        //go for my adv vontroller
                        AdvsBusinessStore().getAdvs(categoryId: nil){ (advsResponse) in
                            if advsResponse?.errorCode != nil {
                                if advsResponse?.errorCode == 0{
                                    saveAdv(context: self.context, appDelegate: self.appDelegate, state: "MyAds", advID: Int32((advsResponse?.advs?.count)!), advCategoryID: Int32( categoryIds[self.advCategoryNameTexField.text!]!))
                                    
                                    //open My Ads
                                     BaseViewController().getSpacificAds(appDelegate: self.appDelegate , context: self.context ,state: "MyAds")
                                    
                                    
                                }
                           
                            }else{
                                print("ConnectionError2")
                            }
                           
                        }
                        print("your adv posted succsefuly")

                    }
                }else{
                    print("connection error")
                }
                
            }
        }

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advImages.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width-20)/3
        let height = collectionView.frame.height
        
        return CGSize(width : width , height : height)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvImagesCollectionViewCell", for: indexPath)as! AdvImagesCollectionViewCell
        cell.SetModel(image: advImages[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 && imagesLessThan8{
            //open image dialoag for cam or upload
            UploadImage()
            
            
           // collectionView.reloadData()
            
        }
        
    }
    func UploadImage()
    {
        
        
        let alert = UIAlertController(title: "Choose one of the following:", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
           
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.present(self.imagePicker, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
           self.navigationController?.popViewController(animated: true)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func alarmForUnLogedUser(){
        
        let alert = UIAlertController(title: "Please Login First", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
            
            let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            self.navigationController?.pushViewController(targetVC, animated: true)
            
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
           self.navigationController?.popViewController(animated: true)
            
        }))
        self.present(alert, animated: true, completion: nil)

        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            
            if advImages.count == 8{
                advImages.remove(at: 0)
                imagesLessThan8=false
            }
            
            advImages.append(pickedImage)
            imagesCollectionView.reloadData()
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "File format is not supported" , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
