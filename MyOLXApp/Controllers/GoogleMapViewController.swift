//
//  GoogleMapViewController.swift
//  MyOLXApp
//
//  Created by Hadeer Kamel on 10/16/17.
//  Copyright © 2017 Hadeer Kamel. All rights reserved.
//


import UIKit
import GoogleMaps
import MapKit

class GoogleMapViewController: UIViewController,
CLLocationManagerDelegate,GMSMapViewDelegate {
   
    @IBOutlet weak var mapView: GMSMapView!
    let marker = GMSMarker()
    var lat: Double!
    var lng: Double!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        
        initializeMap()
        
    }
    
    
    
    func initializeMap() {
        
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 5)
        
        mapView.camera = camera
        
        marker.map = nil
        
        // Creates a marker in the center of the map.
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
       // marker.title = "Sydney"
       // marker.snippet = "Australia"
        marker.map = mapView
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        
        if (UIApplication.shared.canOpenURL(URL(string: "https:t//maps.google.com")!)) {
            
            UIApplication.shared.open(URL(string: "https://maps.google.com/?q=@\(marker.position.latitude),\(marker.position.longitude)")!, options: [:], completionHandler: nil)
            
        } else {
            print("cant use google maps")
        }
        
        return false
    }
    
}
