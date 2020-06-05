//
//  UIImageView+Ext.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit


extension ProductImage {
    
    func setPicture(fromUrl urlString: String ) {
        guard let url = URL(string: urlString) else {
            return
        }
        let cacheString = NSString(string: url.absoluteString)
        if let imageFromCache = Networker.shared.cache.object(forKey: cacheString) {
            self.image = imageFromCache
            self.stopAnimatingActivity()
            return
        }
        
        NetworkManager.shared.downloadPicture(fromUrl: urlString) { (image) in
            guard let image = image  else {
                return
            }
            
            self.image = image
            Networker.shared.cache.setObject(image, forKey: cacheString)
            self.stopAnimatingActivity()
        }
    }
    
    func setPictureForCollectionView(for url: String, cell: UICollectionViewCell, indexPath: IndexPath) {
        let cacheString = NSString(string: url)
        if let imageFromCache = Networker.shared.cache.object(forKey: cacheString) {
            self.image = imageFromCache
            self.stopAnimatingActivity()
            return
        }
        
        NetworkManager.shared.downloadPicture(fromUrl: url) { (image) in
            guard let image = image else { return }
            if (cell.tag == indexPath.row) {
                self.image = image
                self.stopAnimatingActivity()
            }
        }
    }
}
