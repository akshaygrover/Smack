//
//  CreateAccountVC.swift
//  Smack
//
//  Created by akshay Grover on 2017-08-11.
//  Copyright © 2017 akshay Grover. All rights reserved.
//

import UIKit
import Alamofire

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            
            if avatarName.contains("light") && bgColor == nil {
                userImage.backgroundColor = UIColor.lightGray
            }
            
        }
        
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBAction func createAccountTapped(_ sender: RoundedBtn) {
        
        
        guard let email = emailField.text, emailField.text != ""
            else {
                warningLbl.text = "please fill all fields"
                warningLbl.flash()
                sender.shake()
                return
                
        }
        guard let password = passwordField.text , passwordField.text != ""
            else {
                warningLbl.text = "please fill all fields"
                warningLbl.flash()
                sender.shake()
                 return
        }
        guard let username = usernameField.text, usernameField.text != ""
            else {
                warningLbl.text = "please fill all fields"
                warningLbl.flash()
                sender.shake()
                 return
        }
        
        guard self.isValid(email) == true
            else { warningLbl.text = "enter valid email"
                emailField.pulsate()
                warningLbl.flash()
                sender.shake()
                 return
        }
        
        guard self.isPasswordValid(password) == true
        else {
            warningLbl.text = "password contains atleast 7 characters"
            passwordField.pulsate()
            warningLbl.flash()
            sender.shake()
            return
        }
        
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.registerUser(email: email, password: password) { (sucess) in
            
            if sucess {
                // print("user registered!")
                AuthService.instance.loginUser(email: email, password: password, completion: { (sucess) in
                    if sucess {
                        // print("logged in user")
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (sucess) in
                            if sucess {
                                print("user created", UserDataService.instance.name)
                                self.spinner.stopAnimating()
                                self.spinner.isHidden = true
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                                
                            }
                        })
                    }
                })
            } else {
                self.warningLbl.text = "User not registered, try again"
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
    }
    
    @IBAction func chooseAvatarTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBackgroundColorTapped(_ sender: UIButton) {
        
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b   = CGFloat(arc4random_uniform(255))/255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 0.8)
        avatarColor = "[\(r),\(g),\(b),1]"
        UIView.animate(withDuration: 0.3){
            self.userImage.backgroundColor = self.bgColor
        }
    }
    
    func setupView() {
        
        spinner.isHidden = true
        usernameField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSForegroundColorAttributeName: smackPurplePlaceholder])
        emailField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: smackPurplePlaceholder])
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: smackPurplePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    func handleTap(){
        view.endEditing(true)
    }
    
    func isValid(_ email: String) -> Bool {
        
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func isPasswordValid(_ password : String) -> Bool{
        if password.characters.count >= 7 {
            return true
        } else {
            return false
        }
        
    }
    
    
}
