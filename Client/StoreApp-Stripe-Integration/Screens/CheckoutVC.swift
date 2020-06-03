//
//  CheckoutVC.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 03/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit
import Stripe

class CheckoutVC: UIViewController {

    var cardTextField: STPPaymentCardTextField!
    var buttonPay: LLButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configure()
        layoutUI()
    }
    
    
    private func configure() {
        title = "Checkout"
        
        cardTextField = STPPaymentCardTextField(frame: .zero)
        buttonPay = LLButton(backgroundColor: .systemGreen, title: "Pay")
        buttonPay.addTarget(self, action: #selector(pay), for: .touchUpInside)
    }
    
    
    private func layoutUI() {
        view.addSubview(cardTextField)
        view.addSubview(buttonPay)
        cardTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            cardTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            buttonPay.topAnchor.constraint(equalTo: cardTextField.bottomAnchor, constant: padding),
            buttonPay.leadingAnchor.constraint(equalTo: cardTextField.leadingAnchor),
            buttonPay.trailingAnchor.constraint(equalTo: cardTextField.trailingAnchor),
            buttonPay.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc private func pay() {
        print("Pay initialiazed")
        
        var array = [Int]()
        array.append(3)
        array.append(2)
        array.append(45)
 
        let json: [String: Any] = [
            "currency": "EUR",
            "items": array
        ]
        NetworkManager.shared.getPaymentIntent(for: json) { (result) in
            switch result {
                
            case .success(let clientSecret):
                print(clientSecret)
            case .failure(let error):
                print(error)
            }
        }
        
    }

}
