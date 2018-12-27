//
//  PopUpViewController.swift
//  Features
//
//  Created by Archana Rath on 7/31/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    // labels
    @IBOutlet weak var LatitudeLbl: UILabel!
    @IBOutlet weak var LongitudeLbl: UILabel!
    @IBOutlet weak var AddressLbl: UILabel!
    @IBOutlet weak var AddressLbl2: UILabel!
    
    
    // variables to hold data
    var latitude: String = ""
    var longitude: String = ""
    var address: String = ""
    var address2: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        // sets labels to the data passed from previous VC
        LatitudeLbl.text = "Latitude:" + latitude
        LongitudeLbl.text = "Longitude:" + longitude
        AddressLbl.text = address
        AddressLbl2.text = address2
    }

    @IBAction func ClosePopUp(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
