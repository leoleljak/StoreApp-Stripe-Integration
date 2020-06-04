//
//  NetworkManager.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit


struct NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    
    func getProducts(completionHandler: @escaping(Result<[Product], Error>) -> Void){
        Networker.shared.performRequest(urlString: "\(Constants.API_URL)products.php") { (data) in
            do{
                let products = try self.decoder.decode([Product].self, from: data)
                completionHandler(.success(products))
            }catch{
                completionHandler(.failure(error))
            }
            
        }
        
    }
    
    
    func getPaymentIntent(for data: [String: Any], completionHandler: @escaping(Result<PaymentIntent, LLNetworkError>) -> Void){
        Networker.shared.performPOSTRequest(urlString: "\(Constants.API_URL)stripe.php", jsonData: data) { result in
            
            switch result {
            case .success(let data):
                do{
                let clientSecret = try self.decoder.decode(PaymentIntent.self, from: data)
                    completionHandler(.success(clientSecret))
                }catch{
                    print(error)
                    completionHandler(.failure(.decodingFailure))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
            
        }
    }
    
    func downloadPicture(fromUrl url: String, completionHandler: @escaping(UIImage?) -> Void ) {
        guard let url = URL(string: url) else {
            return
        }
        let cacheString = NSString(string: url.absoluteString)
        if let imageFromCache = Networker.shared.cache.object(forKey: cacheString) {
            completionHandler(imageFromCache)
            return
        }
        
        Networker.shared.performRequest(urlString: url.absoluteString) { (data) in
            DispatchQueue.main.async {
                guard let image = UIImage(data: data)  else {
                    return
                }
                Networker.shared.cache.setObject(image, forKey: cacheString)
                completionHandler(image)
            }
        }
    }
    
}
