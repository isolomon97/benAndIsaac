//
//  Sign-UpViewController.swift
//  Crypto Project X
//
//  Created by Isaac Solomon on 8/10/20.
//  Copyright © 2020 Isaac Solomon. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signUpOutlet: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
        
    }
    
    func setUpElements(){
        
        //hide error label
        
        errorLabel.alpha = 0
        Utilities.styleTextField(firstName)
        Utilities.styleTextField(lastName)
        Utilities.styleTextField(email)
        Utilities.styleTextField(password)
        Utilities.styleFilledButton(signUpOutlet)
        
        
        
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
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
             lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
                return "Please fill in all fields"
            
        }
        
        //check if the password is valid
        let cleanedEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if Utilities.isValidEmail(cleanedEmail) == false{//not a valid email
            return "Not a valid email"
            
        }
        
        
        if Utilities.isPasswordValid(cleanedPassword) == false {//password isn't secure enough
            return "Make sure your password has a minimum of 8 characters, and contains at least 1 uppercase letter, 1 lowercase letter, and 1 number"
        }
    
        
        return nil
    }
    
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate fields
        let error = validateFields()
        
        if error != nil{//there is an error
            showError(error!)
    
        }
        else{//create user
            
            //create cleaned inputs
            let cleanedFirstName = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedLastName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            Auth.auth().createUser(withEmail: cleanedEmail, password: cleanedPassword) { (result, err) in
                
                
                if err != nil {//check for errors
                    self.showError("Error creating user")
                }
                else{//successful creation of user
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": cleanedFirstName, "lastName" : cleanedLastName, "userid" : result!.user.uid]) { (error) in
                        
                        if error != nil {//error
                            self.showError("Error saving user data")
                            
                        }
                    }
                    
                }
            }
        
        
        //transition to home screen
            self.transitionToHome()
                
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
