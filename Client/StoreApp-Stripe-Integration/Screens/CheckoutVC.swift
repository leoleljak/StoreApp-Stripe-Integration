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
    var shippment: ShippingOptions!
    var product: Product!
    var products: [Product]!
    var clientSecret: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getPaymentIntent()
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
    
    
    private func getPaymentIntent() {
        var productsInCart = [Int]()
        if product != nil {
            productsInCart.append(product.id)
        }else {
            for p in products {
                productsInCart.append(p.id)
            }
        }
        
        let json: [String: Any] = [
            "currency": product.currency.rawValue,
            "items": productsInCart,
            "shippment": shippment.rawValue
        ]
        NetworkManager.shared.getPaymentIntent(for: json) { (result) in
            switch result {
            case .success(let paymentIntent):
                self.clientSecret = paymentIntent.clientSecret
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
    @objc private func pay() {
        guard let paymentIntentClientSecret = clientSecret else {
                return;
            }
            // Collect card details
            let cardParams = cardTextField.cardParams
            let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
            let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
            paymentIntentParams.paymentMethodParams = paymentMethodParams

            // Submit the payment
            let paymentHandler = STPPaymentHandler.shared()
            paymentHandler.confirmPayment(withParams: paymentIntentParams, authenticationContext: self) { (status, paymentIntent, error) in
                switch (status) {
                case .failed:
                    print("Payment failed")
                    break
                case .canceled:
                    print("Payment Canceled")
                    break
                case .succeeded:
                    print("Payment Succeeded")
                    break
                @unknown default:
                    fatalError()
                    break
                }
            }
        }
    
}


extension CheckoutVC: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
