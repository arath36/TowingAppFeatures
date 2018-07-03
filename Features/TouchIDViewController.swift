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
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func testTouch(_ sender: Any) {
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.localizedFallbackTitle = ""
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "test") { (correct, Error) in
                if correct {
                    print ("correct")
                } else {
                    print ("incorrect")
                }
            }
        } else {
            print ("doesn't support biometrics")
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
