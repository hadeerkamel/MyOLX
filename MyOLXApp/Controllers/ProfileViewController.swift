//
//  ProfileViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/15/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class ProfileViewController: UIViewController ,CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var locationMap: MKMapView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeProfileData()
    }
    func initializeProfileData(){
        
        nameLabel.text = logedUserData[0].username
        emailLabel.text = logedUserData[0].email
        phoneLabel.text = logedUserData[0].phone
        addressLabel.text = logedUserData[0].address
        
      // locationMap
        let annotation = MKPointAnnotation()
      //  let regionRadius: CLLocationDistance = 100
        let location = CLLocation(latitude: logedUserData[0].lat, longitude: logedUserData[0].lng)
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))
        
       locationMap.setRegion(coordinateRegion, animated: true)
        annotation.coordinate = location.coordinate
        
       locationMap.addAnnotation(annotation)

    }
    

}
