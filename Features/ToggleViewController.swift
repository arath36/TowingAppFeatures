//
//  ToggleViewController.swift
//  Features
//
//  Created by Archana Rath on 7/17/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit
import LocalAuthentication

class ToggleViewController: UIViewController {

    @IBOutlet weak var touchIDToggle: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let touchIDcheck = UserDefaults.standard.object(forKey: "touchID") {
            // sets the switch to on or off based on if touchID is enables or disabled
            touchIDToggle.setOn(touchIDcheck as! Bool, animated: false)
        } else {
            //default settings, first time user auto disables touchID
            touchIDToggle.setOn(false, animated: false)
        }
        
        
        // disables toggle switch if device doesn't support touchID
        let context:LAContext = LAContext()
        // evaluates if device supports touch ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            // nothing here
        } else {
            //disables toggle switch
            touchIDToggle.isEnabled = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func touchIDSwitched(_ sender: Any) {
        // enables and disables touch ID when toggle is switched
        if touchIDToggle.isOn {
            touchID = true
            UserDefaults.standard.set(touchID, forKey: "touchID")
            
            
            
        } else if touchIDToggle.isOn == false {
            touchID = false
            UserDefaults.standard.set(touchID, forKey: "touchID")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
