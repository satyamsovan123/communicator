//
//  AuthenticationDataModel.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 09/08/23.
//

import Foundation

struct AuthenticationDataModel {
    let username: String
    let password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func checkCredentials() -> Bool {
        var isAuthenticated: Bool = false;
        if(self.username == "u" && self.password == "p") {
            isAuthenticated = true
        } else if(self.username == "u1" && self.password == "p1") {
            isAuthenticated = true
        }
        return isAuthenticated
    }
    
}
