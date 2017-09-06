//
//  LoginVC.swift
//  Smack
//
//  Created by akshay Grover on 2017-08-11.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }

    @IBAction func closePTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtnTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }

    @IBAction func loginTapped(_ sender: RoundedBtn) {
        
        guard let email = usernameField.text, usernameField.text != ""
            else {
                self.warningLbl.text = "Please enter email"
                sender.shake()
                warningLbl.flash()
                return
                }
        guard let password = passwordField.text , passwordField.text != ""
            else {
                self.warningLbl.text = "Please enter password"
                sender.shake()
                warningLbl.flash()
                return
        }
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.loginUser(email: email, password: password) { (sucess) in
            if sucess{
                AuthService.instance.findUserByEmail(completion: { (sucess) in
                    if sucess{
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                })
            } else {
                self.warningLbl.text = "Enter valid email and password"
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
        
        
    }
    
    func setupView() {
        
        spinner.isHidden = true
        usernameField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: smackPurplePlaceholder])
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: smackPurplePlaceholder])
        
    }
}
