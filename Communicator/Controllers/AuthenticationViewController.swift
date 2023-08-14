//
//  ViewController.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 08/08/23.
//

import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

class AuthenticationViewController:  UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var username: String = ""
    var password: String = ""
    var message: String = ""
    
    var authenticationManager = AuthenticationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.addBottomBorder()
        self.passwordTextField.addBottomBorder()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        authenticationManager.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToDataView") {
            // let destinationViewController = segue.destination as! DataViewController
        } else if(segue.identifier == "goToAuthenticationFailed") {
            let destinationViewController = segue.destination as! AuthenticationFailedViewController
            destinationViewController.message = message ?? "You failed miserably!"
        }
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        self.username = usernameTextField.text ?? ""
        self.password = passwordTextField.text ?? ""
        if(self.username == "" || self.password == "") {
            return
        }
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        
        checkForm()
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.placeholder == " Username") {
            self.username = usernameTextField.text ?? ""
            if(self.username == "") {
                return false
            }
            usernameTextField.endEditing(true)
        } else if(textField.placeholder == " Password") {
            self.password = passwordTextField.text ?? ""
            if(self.password == "") {
                return false
            }
            passwordTextField.endEditing(true)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.placeholder == " Username") {
            usernameTextField.endEditing(true)
        } else if(textField.placeholder == " Password") {
            passwordTextField.endEditing(true)
        }
        checkForm()
        return true
    }
    
    func checkForm() {
        activityIndicator.startAnimating()
        if(self.username == "" || self.password == "") {
            return
        } else {
            let authenticationBackendRequest = AuthenticationBackendRequest(username: self.username, password: self.password)
            authenticationManager.checkCredentials(authenticationBackendRequest: authenticationBackendRequest)
        }
    }
    
}

extension AuthenticationViewController: AuthenticationManagerDelegate {
    func didCompleteAuthentication(_ authenticationManager: AuthenticationManager, authenticationBackendResponse: AuthenticationBackendResponse) {
        print(authenticationBackendResponse)
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.message = authenticationBackendResponse.message
            
            if(authenticationBackendResponse.code == 200) {
                self.performSegue(withIdentifier: "goToDataView", sender: self)
            } else {
                self.performSegue(withIdentifier: "goToAuthenticationFailed", sender: self)
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error)")
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.message = "Some error occured. Please try again."
            self.performSegue(withIdentifier: "goToAuthenticationFailed", sender: self)
        }
    }
    
    
}

