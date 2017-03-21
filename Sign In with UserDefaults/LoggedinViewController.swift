//
//  LoggedinViewController.swift
//  Sign In with UserDefaults
//
//  Created by Silicon Orchard Ltd on 3/21/17.
//  Copyright © 2017 Nahin Ahmed. All rights reserved.
//

import UIKit

class LoggedinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func signOut(_ sender: UIButton) {
        
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "session")
        
        print("Signed Out")
    }

}
