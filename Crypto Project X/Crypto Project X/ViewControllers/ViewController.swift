//
//  ViewController.swift
//  Crypto Project X
//
//  Created by Isaac Solomon on 8/10/20.
//  Copyright © 2020 Isaac Solomon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginOutlet: UIButton!
    
    @IBOutlet weak var signupOutlet: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Utilities.styleFilledButton(loginOutlet)
        
        Utilities.styleHollowButton(signupOutlet)
    }


}

