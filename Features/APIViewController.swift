//
//  APIViewController.swift
//  Features
//
//  Created by Archana Rath on 8/6/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit
import GoogleMaps

class APIViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapSubView: GMSMapView!
    
    let camera = GMSCameraPosition.camera(withLatitude: 29.630399, longitude: -95.602392, zoom: 9.2)
    let circleCenter = CLLocationCoordinate2D(latitude: 29.630399, longitude: -95.602392)
    
// TowDrivers stores all info from API request in an array. driver data is an instance which gets passed to next view controller
    var TowDrivers: [TowLocation] = []
    var driverData: TowLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // map UI set up
        let circ = GMSCircle(position: circleCenter, radius: 26400)
        mapSubView.camera = camera
        mapSubView.delegate = self
        mapSubView.layer.borderWidth = 5
        circ.fillColor = UIColor(red: 0, green: 0, blue: 0.35, alpha: 0.1)
        circ.map = mapSubView
        
        
        // API GET request, stores all data in TowDrivers array
        getDriverData()
        
        
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        // uses TowDrivers array to create visual markers on map
        updateMarkersOnMap()
        
        // repeats the API request so the map updates in real time
        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in

            self.getDriverData()
            self.updateMarkersOnMap()
        }
    }
    
    func getDriverData() {
        
        guard let url = URL(string: "https://devapis.govtow.com/WreckerTowAPI/DriverLocation/GetAllCompanyDrivers?WreckerId=281&towingid=0&latitude=29.6303985&longitude=-95.60239189999999&miles=20&availabletype=0") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("1494175a-a628-4c94-a442-c7f2f005fc4e", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let towLocation = try JSONDecoder().decode([TowLocation].self, from: data)
                    // now the array is formed, use data to populate map
                    self.TowDrivers = towLocation
                    
                }
                catch {
                    print (error.localizedDescription)
                }
            }
            if let error = error {
                print (error.localizedDescription)
            }
            }.resume()
        

    }
    
    func updateMarkersOnMap () {
        for drivers in TowDrivers {
            let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(drivers.latitude), longitude: CLLocationDegrees(drivers.longitude))
            let marker = GMSMarker(position: position)
            marker.title = drivers.Name
            marker.map = self.mapSubView
            if drivers.Name == "URI Towing " {
                marker.icon = UIImage(named: "customMarker")
            }
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // calls pop up when a marker is pressed
        for drivers in TowDrivers {
            if marker.title == drivers.Name {
                driverData = drivers
            }
        }
        performSegue(withIdentifier: "TowDriverPopUpSegue", sender: nil)
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // sends data to TowDriverPopUpViewController so it displays the correct data
        if let TowDataVC = segue.destination as? TowDriverPopUpViewController {
            if let driverData = driverData {
                TowDataVC.driverData = driverData
            }
        }
    }
}
