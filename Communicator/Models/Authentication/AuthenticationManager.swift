//
//  AuthenticationManager.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 10/08/23.
//

import Foundation

protocol AuthenticationManagerDelegate {
    func didCompleteAuthentication(_ authenticationManager: AuthenticationManager, authenticationBackendResponse: AuthenticationBackendResponse)
    func didFailWithError(error: Error)
}

struct AuthenticationManager {
    
    var delegate: AuthenticationManagerDelegate?
    
    let backendUrl: String = "http://localhost:3000/api"
    
    func checkCredentials(authenticationBackendRequest: AuthenticationBackendRequest) {
        let urlString: String = "\(backendUrl)/signin"
        performRequest(urlString: urlString, authenticationBackendRequest: authenticationBackendRequest)
    }
    
    func performRequest(urlString: String, authenticationBackendRequest: AuthenticationBackendRequest) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    func completionHandler(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if(error != nil) {
            delegate?.didFailWithError(error: error!)
        }
        if let safeData = data {
            if let authenticationBackendResponse = parseJSON(data: safeData) {
                delegate?.didCompleteAuthentication(self, authenticationBackendResponse: authenticationBackendResponse)
            }
        }
    }
    
    func parseJSON(data: Data) -> AuthenticationBackendResponse? {
        let decoder = JSONDecoder()
        do {
            let authenticationBackendResponse = try decoder.decode(AuthenticationBackendResponse.self, from: data)
            return authenticationBackendResponse
        } catch {
            return nil
        }
    }
}
