//
//  AuthenticationService.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 09/08/23.
//

import Foundation


struct AuthenticationBackendRequest {
    let username: String
    let password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
