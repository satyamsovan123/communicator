//
//  DataBackendResponse.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 15/08/23.
//

import Foundation

struct DataBackendResponse: Codable {
    let data: [PostData]
    let message: String
    let code: Int
}

struct PostData: Codable {
    let _id: String
    let username: String
    let title: String
    let article: String
}
