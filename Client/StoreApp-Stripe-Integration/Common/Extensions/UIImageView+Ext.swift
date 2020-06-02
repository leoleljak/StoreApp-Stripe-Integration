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
        
        Networker.shared.performRequest(urlString: url.absoluteString) { (data) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.stopAnimatingActivity()
            }
        }
    }
    
    
}
