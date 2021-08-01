//
//  LoginViewController.swift
//  BookRentalAapp
//
//  Created by Eliel Vipata on 7/26/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if(PFUser.current() != nil){
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSkipButton(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    }
    @IBAction func onLoginButton(_ sender: Any) {
//
//        user.email = emailTextField.text
//        user.password = passwordTextField.text
        
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if(user != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
        
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
