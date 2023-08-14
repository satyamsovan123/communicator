//
//  AuthenticationDataModel.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 09/08/23.
//

import Foundation

struct AuthenticationBackendResponse: Codable {
    let data: EmptyData
    let message: String
    let code: Int
}

struct EmptyData: Codable {
    
}
