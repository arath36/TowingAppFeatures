//
//  TowDriverPopUpViewController.swift
//  Features
//
//  Created by Archana Rath on 8/9/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit

class TowDriverPopUpViewController: UIViewController {
    // struct variable to store data
    var driverData: TowLocation?

    // label outlets
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var IDLbl: UILabel!
    @IBOutlet weak var DriverIDLbl: UILabel!
    @IBOutlet weak var LatitudeLbl: UILabel!
    @IBOutlet weak var LongitudeLbl: UILabel!
    @IBOutlet weak var OnLocationDateLbl: UILabel!
    @IBOutlet weak var PhoneLbl: UILabel!
    @IBOutlet weak var IsOccupiedLbl: UILabel!
    @IBOutlet weak var WreckerNameLbl: UILabel!
    @IBOutlet weak var WreckerIDLbl: UILabel!
    @IBOutlet weak var DistancesLbl: UILabel!
    @IBOutlet weak var IsAcceptRejectLbl: UILabel!
    @IBOutlet weak var DriveStatusLbl: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // sets all the passed data to their corresponding labels on the storyboard
        if let driverData = driverData {
            NameLbl.text = driverData.Name
            IDLbl.text = "ID: " + String(driverData.Id)
            DriverIDLbl.text = "Driver ID: " + String(driverData.DriverId)
            LatitudeLbl.text = "Latitude: " + String(driverData.latitude)
            LongitudeLbl.text = "Longitude: " + String(driverData.longitude)
            OnLocationDateLbl.text =  "Date: " + driverData.OnLocationDate
            PhoneLbl.text = "Phone: " + driverData.Phone
            IsOccupiedLbl.text = "Is Occupied: " + driverData.IsOccupied
            WreckerNameLbl.text = "Wrecker Name: " + driverData.WreckerName
            WreckerIDLbl.text = "Wrecker ID: " + String(driverData.WreckerId)
            DistancesLbl.text = "Distances: " + String(driverData.distances)
            IsAcceptRejectLbl.text = "Accept/Reject: " + String(driverData.isacceptreject)
            DriveStatusLbl.text = "Drive Status: " + driverData.DriveStatus
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ClosePopUp(_ sender: Any) {
        // dismisses pop up when close button is pressed
        dismiss(animated: true)
    }
    

}
