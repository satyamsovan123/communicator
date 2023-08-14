//
//  DataViewController.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 09/08/23.
//

import UIKit

class DataViewController: UIViewController {
    
    var token: String = ""
    
    var postData: [PostData] = []
    
    var dataManager = DataManager()
    
    var currentPostNumber: Int = 0
    
    var totalPosts: Int = 0
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var data: UITextView!
    
    @IBAction func showMorePressed(_ sender: UIButton) {
        if(token == "") {
            return
        }
        updateDataInTextView()
        currentPostNumber += 1
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        token = ""
        currentPostNumber = 0
        totalPosts = 0
        postData = []
        self.performSegue(withIdentifier: "goToAuthenticationView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        getData()
    }
    
    func getData() {
        activityIndicator.startAnimating()
        dataManager.getData(token: token)
    }
    
    func updateDataInTextView() {
        if(currentPostNumber > totalPosts - 1) {
            currentPostNumber = 0
        }
        data.text = postData[currentPostNumber].article
    }
}


extension DataViewController: DataManagerDelegate {
    func didReceiveData(_ dataManager: DataManager, dataBackendResponse: DataBackendResponse) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.postData = dataBackendResponse.data
            self.totalPosts = self.postData.count
            self.updateDataInTextView()
            // print(self.postData)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    
}
