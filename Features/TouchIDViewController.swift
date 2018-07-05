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
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.localizedFallbackTitle = ""
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "You can turn off touch ID in settings") { (correct, Error) in
                if correct {
                    print ("correct")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "AuthenticateSegue", sender: nil)
                    }
                } else {
                    print ("incorrect")
                }
            }
        } else {
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AuthenticateSegue", sender: nil)
    }
    @IBAction func textFieldChange(_ sender: Any) {
        maxLength(textFieldName: textField, maxLength: 4)
        
    }
    
    func maxLength (textFieldName: UITextField, maxLength: Int8) {
        var length: Int? = textFieldName.text?.characters.count
        var text = textFieldName.text
        
        if let length = length {
            if length > maxLength {
  
            }
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
