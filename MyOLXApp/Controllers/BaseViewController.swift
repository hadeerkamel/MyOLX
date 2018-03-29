//
//  ViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/4/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import CoreData
var categoryIds: [String: Int]  = ["All": -1,
                                   "Cars": 1 ,
                                   "Real estates": 2,
                                   "Home": 3,
                                   "Mobiles": 4,
                                   "Laptops": 5,
                                   "Fashion": 6]

var categoryNames:[String] = ["All",
                             "Cars" ,
                             "Real estates",
                             "Home",
                             "Mobiles",
                             "Laptops",
                             "Fashion"]

var logedUserData = [LogedUserDataModel]()


class BaseViewController: UIViewController {

    @IBOutlet var MainView: UIView!
    
    @IBOutlet weak var GroupingviewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var leftMenuLeadingConstraints: NSLayoutConstraint!
    var menuAppear :Bool!
    
    @IBOutlet weak var loginOrRegisterButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
//    var logedUserData = [LogedUserDataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Intilaization()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    func Intilaization(){

        menuAppear = false
        
        GroupingviewWidthConstraint.constant=MainView.frame.width
        leftMenuLeadingConstraints.constant = -MainView.frame.width

        //Right Swipping
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        //Shadow Touched
        
        let ShadowViewtouched = UITapGestureRecognizer(target: self, action: #selector (self.didTouchedShadowView))
        self.shadowView.addGestureRecognizer(ShadowViewtouched)
        
        
        
        //Data Base
        context = appDelegate.persistentContainer.viewContext
        
        // Log in button
        loginOrRegisterButton.setRadious(radious: 10)
        loginOrRegisterButton.setShadow()
       
        
    }
    func loadLogedUserData(context_: NSManagedObjectContext){
      //  if logedUserData.count == 0{
        do{
         
            logedUserData = try context_.fetch(LogedUserDataModel.fetchRequest())
            
        }catch{
            print(error)
        
        }
       // }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLoged"){
        //  let   _ = self.MainView
            
            loadLogedUserData(context_: context)
            loginOrRegisterButton.setTitle("Loged As "+logedUserData[0].username!, for: .normal)
            
            //    loginOrRegisterButton.isHidden = true
         //   loadLogedUserData()
            
          //  logedAs.text = logedAs.text! + logedUserData[0].username!
            
            logoutButton.isHidden = false
            
        }
        else{
            
        logoutButton.isHidden = true
            
        }
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
               MenuAppearence()
            default:
                break
            }
        }
    }
    func didTouchedShadowView(){
        MenuAppearence()
    }
    @IBAction func didTapedMenuButton(_ sender: Any) {
        MenuAppearence()
    }
    func MenuAppearence(){
        if !menuAppear {
            leftMenuLeadingConstraints.constant = 0
        }
        else{
            leftMenuLeadingConstraints.constant = -MainView.frame.width
        }
        menuAppear = !menuAppear
    }
    
    @IBAction func didTapedHomeButton(_ sender: Any) {
        print("Home tapped")
        MenuAppearence()
        let targetViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
        self.navigationController?.pushViewController(targetViewController, animated: true)
        
        
    }
    
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
        
      //  loginOrRegisterButton.isHidden = false
      //  logedAs.text = "Loged as "
        loginOrRegisterButton.setTitle("Login/Register", for: .normal)
        UserDefaults.standard.set(false, forKey: "isLoged")
        logoutButton.isHidden = true
        loadLogedUserData(context_: context)
        for object in logedUserData{
            
            context.delete(object)
        }
        do{
            
            let savedAdvs = try context.fetch(AdvsData.fetchRequest())
            for object in savedAdvs{
                
                context.delete(object as! NSManagedObject)
            }
            
        }catch{
            print(error)
            
        }
        appDelegate.saveContext()

        MenuAppearence()
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        
        let targetVC:UIViewController
        
        if(UserDefaults.standard.bool(forKey: "isLoged")){
            targetVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")as! ProfileViewController
        }else{
            targetVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
            
        }
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    
    @IBAction func didTapFavoritsButton(_ sender: Any) {
        //load on predicat "FAvorits"
        
         getSpacificAds(appDelegate: appDelegate , context: context ,state: "Favorits")
            }


    @IBAction func didTapMyAdsButton(_ sender: Any) {
         getSpacificAds(appDelegate: appDelegate , context: context ,state: "MyAds")
    }

    @IBAction func didTapSellYourItemButton(_ sender: Any) {
        let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "AddAdvViewController")as! AddAdvViewController
        self.navigationController?.pushViewController(targetVC, animated: true)
    }

func getSpacificAds(appDelegate: AppDelegate , context: NSManagedObjectContext ,state: String){
    //load on predicat "Favorits"
    
    var result: [AdvsModel] = [AdvsModel]()
    do{
        let request: NSFetchRequest<AdvsData> = AdvsData.fetchRequest()
        request.predicate = NSPredicate(format: "advType == %@" ,state)
        let savedAdv = try context.fetch(request)
        
        AdvsBusinessStore().getAdvs(categoryId: nil){ (requestedAdvsModel) in
            
            if requestedAdvsModel?.errorCode != nil{
                if requestedAdvsModel?.errorCode == 0{
                     for object in savedAdv{
                        for adv in (requestedAdvsModel?.advs)!{
                            if adv.id == Int(object.advID){
                                result.append(adv)
                                break
                            }
                        }
                    }
                    let targetVC = self.storyboard?.instantiateViewController(withIdentifier: "AdvsCollectionViewController")as! AdvsCollectionViewController
                    targetVC.setModel(advs: result)
                    self.navigationController?.pushViewController(targetVC, animated: true)
                }
            }
            else{
                print("Connection Error !")
            }
            
            }
        
        
    }catch{
        print(error)
        
    }
    
}
    
    
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        
        let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController")as! SearchViewController
        self.navigationController?.pushViewController(targetVc, animated: true)
        
    }
    
    
}
func saveAdv(context: NSManagedObjectContext ,appDelegate: AppDelegate,state: String ,advID: Int32 ,advCategoryID: Int32){
    
    let item = AdvsData(context: context)
    item.advType = state
    item.advCategoryID = advCategoryID
    item.advID = advID
    appDelegate.saveContext()
    
}

