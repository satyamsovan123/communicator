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

class AuthenticationViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInPressed(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "goToDataView", sender: self)
         self.performSegue(withIdentifier: "goToAuthenticationFailed", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.addBottomBorder()
        self.passwordTextField.addBottomBorder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToDataView") {
            let destinationViewController = segue.destination as! DataViewController
        } else if(segue.identifier == "goToAuthenticationFailed") {
            let destinationViewController = segue.destination as! AuthenticationFailedViewController
            destinationViewController.message = "You failed miserably!"
        }
    }
    
    
    
    
    
}

