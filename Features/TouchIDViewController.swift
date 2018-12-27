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
                    // evauluates if touchID has been enabled by user
                    if let touchIDCheck = UserDefaults.standard.object(forKey: "touchID") {
                        if touchIDCheck as! Bool == true {
                                    context.localizedFallbackTitle = ""
                                    // touch ID authentication pop up
                                    context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "You can turn off touch ID in settings") { (correct, Error) in
                                        if correct {
                                            // segues to next storyboard when correct finger print is detected
                                            DispatchQueue.main.async {
                                                self.performSegue(withIdentifier: "AuthenticateSegue", sender: nil)
                                            }
                                        } else {
                                            // nothing when incorrect fingerprint is detected. Automatically quits after 3 failed attempts
                                        }
                                    }
                        }
                    }
                } else {
                    // nothing if device doesn't support touchID
                }
                // sets text field delegate to TouchIDViewController
                textField.delegate = self
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        // segues to next storyboard for dev purposes
        if textField.text == "1234" {
        performSegue(withIdentifier: "AuthenticateSegue", sender: nil)
        } else {
            
            // error alert if wrong password is pressed
            let alert = UIAlertController(title: "Error", message: "Passcode is incorrect", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(action)
           present(alert, animated: true, completion: nil)
        }
    }
    
    
    // limits characters in the UITextField to 4
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 4
    }
  


}
