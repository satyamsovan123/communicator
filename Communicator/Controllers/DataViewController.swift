//
//  DataViewController.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 09/08/23.
//

import UIKit

class DataViewController: UIViewController {
    
    var token: String = ""
    
    @IBOutlet weak var data: UITextView!
    
    @IBAction func showMorePressed(_ sender: UIButton) {
        if(token != "") {
            
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        token = ""
        self.performSegue(withIdentifier: "goToAuthenticationView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(token)
    }
    
}
