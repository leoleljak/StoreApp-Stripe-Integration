//
//  ProductsViewController.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureNavBar() {
        let rightItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.avatarImage), style: .plain, target: self, action: #selector(avatarSelected))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    
    @objc func avatarSelected() {
        print("Dummy Avatar Selected")
    }

    

}
