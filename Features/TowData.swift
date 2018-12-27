//
//  TowData.swift
//  Features
//
//  Created by Archana Rath on 7/13/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import Foundation
import UIKit

var touchID = Bool()
// TowData stores the API data from the VoiceToTextViewController
struct TowData: Decodable {
    let Color: String
    let Make: String
    let RecordId: String
    let TowId: Int
    let Vin: String

    init (json:[String:Any]) {
        Color = json["Color"] as? String ?? ""
        Make = json["Make"] as? String ?? ""
        Vin = json["Vin"] as? String ?? ""
       TowId = json["TowId"] as? Int ?? 0
       RecordId = json["RecordId"] as? String ?? ""
        
    }
 
}


// TowLocation stores the data from the APIViewController
struct TowLocation: Decodable {
    let Id: Int
    let Name: String
    let DriverId: Int
    let latitude: Float
    let longitude: Float
    let OnLocationDate: String
    let Phone: String
    let IsOccupied: String
    let WreckerName: String
    let WreckerId: Int
    let distances: Float
    let isacceptreject: Bool
    let DriveStatus: String
 
    
    init (json:[String:Any]) {
        
        Id = json["Id"] as? Int ?? 0
        Name = json["Name"] as? String ?? ""
        DriverId = json["DriverId"] as? Int ?? 0
        latitude = json["latitude"] as? Float ?? 0.0
        longitude = json["longitude"] as? Float ?? 0.0
        OnLocationDate = json["OnLocationDate"] as? String ?? ""
        Phone = json["Phone"] as? String ?? ""
        IsOccupied = json["IsOccupied"] as? String ?? ""
        WreckerName = json["WreckerName"] as? String ?? ""
        WreckerId = json["WreckerId"] as? Int ?? 0
        distances = json["distances"] as? Float ?? 0.0
        isacceptreject = json["isacceptreject"] as? Bool ?? false
        DriveStatus = json["DriveStatus"] as? String ?? ""

        
    }
 
}


