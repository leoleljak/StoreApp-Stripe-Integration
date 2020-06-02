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
}
