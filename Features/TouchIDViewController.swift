//
//  TouchIDViewController.swift
//  Features
//
//  Created by Archana Rath on 7/3/18.
//  Copyright © 2018 Austin Rath. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.localizedFallbackTitle = ""
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in with Touch ID") { (correct, Error) in
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
