//
//  NetworkManager.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation
let API_URL = "http://192.168.1.8/api/products.php"

struct NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    func getProducts(completionHandler: @escaping(Result<[Product], Error>) -> Void){
        Networker.shared.performRequest(urlString: API_URL) { (data) in
            do{
                let products = try self.decoder.decode([Product].self, from: data)
                completionHandler(.success(products))
            }catch{
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
}
