//
//  ViewController.swift
//  chessTimer
//
//  Created by Isaac Solomon on 7/3/20.
//  Copyright © 2020 Isaac Solomon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timeOne = 600
    var timeTwo = 600
    
    var timerOne = Timer()
    var timerTwo = Timer()
    
    
    
    @IBOutlet weak var clockOne: UILabel!
    @IBOutlet weak var clockTwo: UILabel!
    
    
    @IBOutlet weak var disableOne: UIButton!
    @IBOutlet weak var disableTwo: UIButton!
    
    @IBAction func playerOnePress(_ sender: Any) {
        
        timerTwo = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.clockTwoGo), userInfo: nil, repeats: true)
        timerOne.invalidate()
        
        disableTwo.isEnabled = true
        disableOne.isEnabled = false
    }
    
    @objc func clockTwoGo(){
        timeTwo -= 1
        clockTwo.text = String(timeTwo)
        
        if timeTwo == 0{
            timerTwo.invalidate()
            
            disableOne.isEnabled = false
            disableTwo.isEnabled = false
        }
        
    }
    
    
    
    @IBAction func playerTwoPress(_ sender: Any) {
        
        timerOne = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.clockOneGo), userInfo: nil, repeats: true)
        timerTwo.invalidate()
        
        disableOne.isEnabled = true
        disableTwo.isEnabled = false
        
        
    }
    
    @objc func clockOneGo(){
        timeOne -= 1
        clockOne.text = String(timeOne)
        
        if timeOne == 0{
            timerOne.invalidate()
            disableOne.isEnabled = false
            disableTwo.isEnabled = false
        }
        
    }
    
    
    @IBAction func reset(_ sender: Any) {
        
        timeOne = 600
        timeTwo = 600
        
        timerOne.invalidate()
        timerTwo.invalidate()
        
        clockOne.text = String(timeOne)
        clockTwo.text = String(timeTwo)
        
        
        
        disableOne.isEnabled = true
        disableTwo.isEnabled = true
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


}

