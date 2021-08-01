//
//  SignupViewController.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/26/21.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var passwordFIeld: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignupButton(_ sender: Any) {
        
        let validEmail = validateEmailAddress(email: emailTextField.text!)
        let validPassword = validatePassword(password:passwordFIeld.text!)
        
//        if( validEmail == false){
//            
//            let alert = UIAlertController(title: "Invalid Email", message: "You must already have an active @purdue.edu email to signup", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//            }))
//            self.present(alert, animated: true, completion: nil)
//            
//        }
//        
//        if( validPassword == false){
//            
//            let alert = UIAlertController(title: "Invalid Passowrd", message: "Password must have minimum 8 characeters, one number and one special character.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//            }))
//            self.present(alert, animated: true, completion: nil)
//            
//        }
        
//        if(validEmail && validPassword){
            let user = PFUser()
            user.email = emailTextField.text
            user.password = passwordFIeld.text
            user["fullname"] = fullname.text
            user.username = fullname.text
            user.signUpInBackground { (success, error) in
                if(success){
                    print("Signup successful")
                    self.performSegue(withIdentifier: "createSegue", sender: nil)
                } else if((error) != nil){
                    print(error?.localizedDescription)
                }
            }
//        }
        
    }
    

    func validatePassword(password:String) -> Bool {
        
        // Password must contain a minimum of eight characters, at least one letter, one number and one special character:
        
        let range = NSRange(location: 0, length: password.utf16.count)
        let regex = try! NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
        if(regex.firstMatch(in: password, options: [], range: range) != nil){
            return true
        }
        return false
    }
    
    func validateEmailAddress(email:String) -> Bool{
        
        //Check if student owns a purdue email
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: "^[a-z0-9](\\.?[a-z0-9]){5,}@purdue\\.edu$")
        if(regex.firstMatch(in: email, options: [], range: range) != nil){
            return true
        }
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
