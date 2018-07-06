//
//  TouchIDViewController.swift
//  Features
//
//  Created by Archana Rath on 7/3/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context:LAContext = LAContext()
        // evaluates if device supports touch ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.localizedFallbackTitle = ""
            // touch ID pop up 
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "You can turn off touch ID in settings") { (correct, Error) in
                if correct {
                    // performed when correct fingerprint is detected
                    print ("correct")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "AuthenticateSegue", sender: nil)
                    }
                } else {
                    print ("incorrect")
                }
            }
        } else {
            // no pop up if device doesn't support touch ID
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        // segues to voice to text storyboard for dev purposes
        performSegue(withIdentifier: "AuthenticateSegue", sender: nil)
    }
    @IBAction func textFieldChange(_ sender: Any) {
        
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
