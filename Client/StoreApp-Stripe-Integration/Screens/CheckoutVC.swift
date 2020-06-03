//
//  CheckoutVC.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 03/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configure()
    }
    
    
    private func configure() {
        title = "Checkout"
    }

}
