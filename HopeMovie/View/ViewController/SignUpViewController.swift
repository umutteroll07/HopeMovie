//
//  SignUpViewController.swift
//  HopeMovie
//
//  Created by Umut Erol on 10.02.2024.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_psw: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }
    

    @IBAction func clicked_signUp(_ sender: Any) {
        if txt_email.text != "" && txt_psw.text != "" {
            Auth.auth().createUser(withEmail: txt_email.text!, password: txt_psw.text!) { result, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: "There was a problem logging in")
                }
                else{
                    let viewController = self.storyboard?.instantiateViewController(identifier: "toViewController") as! ViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                }
            }
        }
        else{
            self.makeAlert(title: "Error", message: "There was a problem logging in")
        }
        
    }
    
    @IBAction func clicked_backToSignIn(_ sender: Any) {
        
        let signInViewController = self.storyboard?.instantiateViewController(identifier: "tosignInViewController") as! SingInViewController
        self.navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    
    func makeAlert(title : String , message : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
}
