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
    func didReceiveToken(_ authenticationManager: AuthenticationManager, token: String)
}

struct AuthenticationManager {
    
    var delegate: AuthenticationManagerDelegate?
    
    let backendUrl: String = "http://192.168.29.33:3000/api"
    
    func checkCredentials(authenticationBackendRequest: AuthenticationBackendRequest) {
        let urlString: String = "\(backendUrl)/signin"
        performBackendRequest(urlString: urlString, authenticationBackendRequest: authenticationBackendRequest)
    }
    
    func performBackendRequest(urlString: String, authenticationBackendRequest: AuthenticationBackendRequest) {
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = convertToJSON(data: authenticationBackendRequest)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: urlRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    func completionHandler(data: Data?, urlResponse: URLResponse?, error: Error?) {
        
        var token: String = ""
        
        if(error != nil) {
            delegate?.didFailWithError(error: error!)
        }

        if let safeUrlResponse = urlResponse {
            if let rawToken = (safeUrlResponse as! HTTPURLResponse).value(forHTTPHeaderField: "Authorization") {
                token = rawToken.components(separatedBy: " ")[1]
                delegate?.didReceiveToken(self, token: token)
            }
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
    
    func convertToJSON(data: AuthenticationBackendRequest) -> Data? {
        let encoder = JSONEncoder()
        do {
            let authenticationBackendRequest = try encoder.encode(data)
            return authenticationBackendRequest
        } catch {
            return nil
        }
    }
}
