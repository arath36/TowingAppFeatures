//
//  GoogleMapViewController.swift
//  Features
//
//  Created by Archana Rath on 7/20/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit
import GoogleMaps
import SpriteKit

class GoogleMapViewController: UIViewController, GMSMapViewDelegate {
   
    // label outlets, displays current longitutde, latitude, and address
    @IBOutlet weak var latitudeLbl: UILabel!
    @IBOutlet weak var longitudeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    
    // outlet for mapView
    @IBOutlet weak var mapSubView: GMSMapView!
    var location = CLLocation()
    
    // initial camera position, given location isn't enabled. Set over Texas.
    let camera = GMSCameraPosition.camera(withLatitude: 32, longitude: -97, zoom: 6.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize map inside of subview, set up mapView UI
        mapSubView.camera = camera
        mapSubView.delegate = self
        mapSubView.isMyLocationEnabled = true
        mapSubView.layer.borderWidth = 8
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // set map view camera over current location if it is accessible
        
        mapSubView.settings.myLocationButton = true
        
        if let mylocation = mapSubView.myLocation {
            // set map position based on location
            mapSubView.camera = GMSCameraPosition.camera(withTarget: mylocation.coordinate, zoom: 10.0)
            // Fetches location data and sets them to the label outlets
            updateLocationData()
            // updates longitude, latitude, and address in real time
            var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                self.updateLocationData()
            }
            
        } else {
            // nothing since location isn't enabled
        }
        
        
        
    }

    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        // show pop up when blue location dot is pressed
        performSegue(withIdentifier: "PopUpSegue", sender: nil)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass all the data (long, lat, and address) to next PopUpViewController to display
        if let PopUpVC = segue.destination as? PopUpViewController {
            // latitude
            if let latitude = mapSubView.myLocation?.coordinate.latitude as? Double {
                let roundedLatitude = (latitude*10000).rounded()/10000
                let lat = String(roundedLatitude)
                PopUpVC.latitude = lat
            }
            // longitude
            if let longitude = mapSubView.myLocation?.coordinate.longitude as? Double {
                let roundedLongitude = (longitude*10000).rounded()/10000
                let longit = String(roundedLongitude)
                PopUpVC.longitude = longit
            }
            
            // Get address and send to next view controller
            CLGeocoder().reverseGeocodeLocation((mapSubView.myLocation)!) { (placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    // pm.country = country
                    // pm.locality = city
                    // pm.subLocality = sub divisions of cities ex. "valley ranch"
                    // pm.thoroughfare = Street
                    // pm.postalCode = Zip code
                    // pm.subThoroughfare = Street Number
                    //  pm.administrativeArea = State
                    
                    
                    var addressString : String = ""
                    var addressString2 : String = ""
                    if pm.subThoroughfare != nil {
                        addressString = addressString + pm.subThoroughfare! + " "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare!
                    }
                    
                    
                    
                    if pm.locality != nil {
                        addressString2 = addressString2 + pm.locality! + ", "
                    }
                    if pm.administrativeArea != nil {
                        addressString2 = addressString2 + pm.administrativeArea! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString2 = addressString2 + pm.postalCode! + " "
                    }
                    
                    
                    PopUpVC.address = addressString
                    PopUpVC.address2 = addressString2
                }
                
            }
            
        }
        
        
        
    }
    
    func updateLocationData() {
        // function which updates the longitude, latitude, and address
        // set latitude
        let roundedLatitude = (mapSubView.myLocation!.coordinate.latitude*10000).rounded()/10000
        let lat = String(roundedLatitude)
        latitudeLbl.text = "Latitude: " + lat
        // set longitude
        let roundedLongitude = (mapSubView.myLocation!.coordinate.longitude*10000).rounded()/10000
        let longit = String(roundedLongitude)
        longitudeLbl.text = "Longitude: " + longit
        // Fetches address from current geocoordinates, set's it to addressLbl
        CLGeocoder().reverseGeocodeLocation((mapSubView.myLocation)!) { (placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                
                // pm.country = country
                // pm.locality = city
                // pm.subLocality = sub divisions of cities ex. "valley ranch"
                // pm.thoroughfare = Street
                // pm.postalCode = Zip code
                // pm.subThoroughfare = Street Number
                //  pm.administrativeArea = State
                
                
                var addressString : String = ""
                
                if pm.subThoroughfare != nil {
                    addressString = addressString + pm.subThoroughfare! + " "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.administrativeArea != nil {
                    addressString = addressString + pm.administrativeArea! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                self.addressLbl.text = addressString
                
            }
            
        }
    }
    


}
