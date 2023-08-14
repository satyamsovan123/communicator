//
//  DataManager.swift
//  Communicator
//
//  Created by Satyam Sovan Mishra on 15/08/23.
//

import Foundation

protocol DataManagerDelegate {
    func didReceiveData(_ dataManager: DataManager, dataBackendResponse: DataBackendResponse)
    func didFailWithError(error: Error)
}

struct DataManager {
    var delegate: DataManagerDelegate?
    
    let backendUrl: String = "http://localhost:3000/api"
    
    func getData(token: String) {
        let urlString: String = "\(backendUrl)/getalldata"
        performBackendRequest(urlString: urlString, token: token)
    }
    
    func performBackendRequest(urlString: String, token: String) {
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: urlRequest, completionHandler: completionHandler)
            task.resume()
        }
    }
    
    func completionHandler(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if(error != nil) {
            delegate?.didFailWithError(error: error!)
        }
        
        if let safeData = data {
            // print(String(data: safeData, encoding: .utf8))
            if let dataBackendResponse = self.parseJSON(data: safeData) {
                delegate?.didReceiveData(self, dataBackendResponse: dataBackendResponse)
            }
        }
    }
    
    func parseJSON(data: Data) -> DataBackendResponse? {
        let decoder = JSONDecoder()
        do {
            let dataBackendResponse = try decoder.decode(DataBackendResponse.self, from: data)
            return dataBackendResponse
        } catch {
            return nil
        }
    }
    
}
