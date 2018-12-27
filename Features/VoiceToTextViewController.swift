//
//  VoiceToTextViewController.swift
//  Features
//
//  Created by Archana Rath on 7/3/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit

class VoiceToTextViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var recordID: UILabel!
    @IBOutlet weak var VinText: UITextField!
    @IBOutlet weak var MakeText: UITextField!
    @IBOutlet weak var ColorText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VinText.delegate = self
        MakeText.delegate = self
        ColorText.delegate = self
        
        
        // Fetches data from API
        guard let url = URL(string: "https://devapis.govtow.com/WreckerTowAPI/Tow/SelectTowDetails?TowId=4629") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("1494175a-a628-4c94-a442-c7f2f005fc4e", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print (data)
                do {
                    let towData = try JSONDecoder().decode(TowData.self, from: data)
                    DispatchQueue.main.async {
                        self.VinText.text = towData.Vin
                        self.ColorText.text = towData.Color
                        self.MakeText.text = towData.Make
                        self.recordID.text = "RecordID: " + towData.RecordId
                    }
                    
                }
                catch {
                    print (error)
                    DispatchQueue.main.async {
                        // error handling if something goes wrong while parsing fetched data
                        self.errorAlert()
                        self.recordID.text = "RecordID:"
                    }
                }
            }
            if let response = response {
              print(response)
            }
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    // error handling if something goes wrong while fetching data
                    self.errorAlert()
                    self.recordID.text = "RecordID:"
                }
                
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func errorAlert() {
        // alert function
        let alert = UIAlertController(title: "Error", message: "Something went wrong, please try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    func textFieldShouldReturn(_ VinText: UITextField) -> Bool {
        // dismisses keyboard when done key is hit
        self.view.endEditing(true)
        return true
        
    }
    

}
