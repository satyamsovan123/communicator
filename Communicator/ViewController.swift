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

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.textField.addBottomBorder()
        // Do any additional setup after loading the view.
    }


}

