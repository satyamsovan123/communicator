//
//  DataViewController.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 09/08/23.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var data: UITextView!
    
    @IBAction func showMorePressed(_ sender: UIButton) {
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
         self.performSegue(withIdentifier: "goToAuthenticationView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
