//
//  UIImageView+Ext.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit


extension ProductImage {
    
    func setPicture(fromUrl url: String ) {
        guard let url = URL(string: url) else {
            return
        }
        let cacheString = NSString(string: url.absoluteString)
        if let imageFromCache = Networker.shared.cache.object(forKey: cacheString) {
            self.image = imageFromCache
            self.stopAnimatingActivity()
            return
        }
        
        Networker.shared.performRequest(urlString: url.absoluteString) { (data) in
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    return
                }
                self.image = image
                Networker.shared.cache.setObject(image, forKey: cacheString)
                self.stopAnimatingActivity()
            }
        }
    }
    
    
    
    
}
