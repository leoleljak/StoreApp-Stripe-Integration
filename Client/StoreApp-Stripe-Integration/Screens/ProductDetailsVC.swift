//
//  ProductDetailsVC.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        
    }
    
    
    func configure() {
        title = product.name
        
        let barItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressedDone))
        navigationItem.rightBarButtonItem = barItem
    }
    
    
    @objc func pressedDone() {
        self.dismiss(animated: true)
    }
    
    
    
    

    

}
