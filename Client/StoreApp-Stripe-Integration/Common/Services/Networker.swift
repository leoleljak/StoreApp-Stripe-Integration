//
//  NetworkManager.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation

struct Networker {
    static let shared = Networker()
    
    #warning("Proslijediti već napravljeni URL")
    func performRequest(urlString: String, completionHandler: @escaping (Data)->Void) {
        let urlStringWithoutSpace = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url = URL(string: urlStringWithoutSpace){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }else if let safeData = data {
                    completionHandler(safeData)
                }
            }
            task.resume()
        }
    }
    
    
    func performPOSTRequest(urlString: String, jsonData: [String: Any], completionHandler: @escaping (Result<Data, LLNetworkError>)->Void) {
        let urlStringWithoutSpace = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: urlStringWithoutSpace) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody =  try? JSONSerialization.data(withJSONObject: jsonData)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(.networkFailure))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponseServer))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            completionHandler(.success(data))
            
        }
        
        task.resume()
    }
}
