//
//  AuthenticationFailedViewController.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 09/08/23.
//

import UIKit

class AuthenticationFailedViewController: UIViewController {

    var message: String = "Authentication failed. Please try again."
    @IBOutlet weak var authenticationFailedMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationFailedMessage.text = message
    }

    @IBAction func signInPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
