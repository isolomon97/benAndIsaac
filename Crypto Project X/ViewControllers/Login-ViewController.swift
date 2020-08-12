//
//  Login-ViewController.swift
//  Crypto Project X
//
//  Created by Isaac Solomon on 8/10/20.
//  Copyright © 2020 Isaac Solomon. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var loginOutlet: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        //hide error label
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailOutlet)
        Utilities.styleTextField(passwordOutlet)
        Utilities.styleFilledButton(loginOutlet)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func validateFields() -> String? {
        //check that all fields are filled in
              if emailOutlet.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                  passwordOutlet.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                  {
                      return "Please fill in all fields"
                  
              }
        
        //check if the password is valid
               let cleanedEmail = emailOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let cleanedPassword = passwordOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmail(cleanedEmail) == false{//not a valid email
            return "Not a valid email"
            
        }
        
        
        if Utilities.isPasswordValid(cleanedPassword) == false {//password isn't secure enough
            return "Please make sure your password has a minimum of 8 characters, and contains at least 1 uppercase letter, 1 lowercase letter, and 1 number"
        }
        
        
        
           
      
           
           return nil
       }
    
    
    
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let error = validateFields()

        
        if error != nil {
            showError(error!)
        }
        else{
            
            
            let cleanedEmail = emailOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let cleanedPassword = passwordOutlet.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            
            Auth.auth().signIn(withEmail: cleanedEmail, password: cleanedPassword) { (result, error) in
                
                
                if error != nil {//couldn't sign in
                    
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                    
                }
                else{//successful sign in, move to home screen
                    self.transitionToHome()
                }
            }
            
            
            
            
            
        }
        
        
        
       
        
        
        
        
        
        
    }
    
    
    
    func showError(_ message: String){
           errorLabel.text = message
           errorLabel.alpha = 1
       }
    
    func transitionToHome(){
        
        
       let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}
