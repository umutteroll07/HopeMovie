//
//  SingInViewController.swift
//  HopeMovie
//
//  Created by Umut Erol on 10.02.2024.
//

import UIKit
import FirebaseAuth

class SingInViewController: UIViewController {

    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_psw: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            let viewController =  self.storyboard?.instantiateViewController(identifier: "toViewController") as! ViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }

        
    }
    

    @IBAction func clicked_enter(_ sender: Any) {
        if txt_email.text != "" && txt_psw.text != "" {
            Auth.auth().signIn(withEmail: txt_email.text ?? "", password: txt_psw.text ?? "") { result, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: "There was a problem logging in")
                }
                else {
                    let viewController =  self.storyboard?.instantiateViewController(identifier: "toViewController") as! ViewController
                    self.navigationController?.pushViewController(viewController, animated: true)
                 }
            }
            
        }
        else {
            self.makeAlert(title: "Error", message: "There was a problem logging in")
        }
    }
    
    
    @IBAction func clicked_createAccount(_ sender: Any) {
        
        let signUpViewController = self.storyboard?.instantiateViewController(identifier: "tosignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    
    func makeAlert(title : String , message : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
        
    }
    
}
