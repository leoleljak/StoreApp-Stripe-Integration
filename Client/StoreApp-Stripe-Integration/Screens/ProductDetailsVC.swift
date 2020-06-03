//
//  ProductDetailsVC.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController, UIGestureRecognizerDelegate {

    let productImage = ProductImage(frame: .zero)
    var scrollView: UIScrollView!
    let contentView = UIView(frame: .zero)
    let labelUPS = LLTitleLabel(fontSize: 20, fontColor: .label)
    let labelDHL = LLTitleLabel(fontSize: 20, fontColor: .label)
    let bodyLabel = LLBodyLabel(fontSize: 15, fontColor: .secondaryLabel)
    let priceLabel = LLBodyLabel(fontSize: 20, fontColor: .systemGray, weight: .bold)
    let shippingContentView = UIView(frame: .zero)
    let radioButtonUPS = RadioButton(for: .radioUnchecked)
    let radioButtonDHL = RadioButton(for: .radioUnchecked)
    let buttonCart = LLButton(backgroundColor: .systemBlue, title: "Add To Cart")
    let buttonCheckout = LLButton(backgroundColor: .systemGreen, title: "Checkout")
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configure()
        layoutUI()
        fillData()
        
    }
    
    @objc func proba() {
        print("Proba")
    }
    
    
    func configure() {
        title = product.name
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        let barItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressedDone))
        navigationItem.rightBarButtonItem = barItem
        productImage.changeActivityIndicatorColor(to: .blue)
        
        priceLabel.textColor = .systemGreen
        
        shippingContentView.backgroundColor = .systemGray6
        shippingContentView.layer.cornerRadius = 15
        shippingContentView.translatesAutoresizingMaskIntoConstraints = false
        
        radioButtonUPS.changeState()
        radioButtonUPS.delegate = self
        radioButtonDHL.delegate = self
        

        
    }
    
    
    func fillData() {
        productImage.setPicture(fromUrl: product.imageUrl)
        labelUPS.text = "UPS Shippment - 10€ 📦"
        labelDHL.text = "DHL Shippment - 15€ 📦"
        bodyLabel.text = "This is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database"
        priceLabel.text = "\(product.price)\(product.currency.rawValue) "
    }
    
    
    func layoutUI() {
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(productImage)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(shippingContentView)
        shippingContentView.addSubview(radioButtonUPS)
        shippingContentView.addSubview(radioButtonDHL)
        shippingContentView.addSubview(labelUPS)
        shippingContentView.addSubview(labelDHL)
        shippingContentView.addSubview(buttonCart)
        shippingContentView.addSubview(buttonCheckout)
        
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            
            productImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            productImage.widthAnchor.constraint(equalToConstant: 180),
            productImage.heightAnchor.constraint(equalToConstant: 250),
            
            bodyLabel.topAnchor.constraint(equalTo: productImage.topAnchor),
            bodyLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            priceLabel.bottomAnchor.constraint(equalTo: productImage.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: bodyLabel.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 23),
            
            shippingContentView.leadingAnchor.constraint(equalTo: productImage.leadingAnchor),
            shippingContentView.trailingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            shippingContentView.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 20),
            shippingContentView.heightAnchor.constraint(equalToConstant: 115),
            
            radioButtonUPS.topAnchor.constraint(equalTo: shippingContentView.topAnchor, constant: 20),
            radioButtonUPS.leadingAnchor.constraint(equalTo: shippingContentView.leadingAnchor, constant: 20),
            radioButtonUPS.widthAnchor.constraint(equalToConstant: 35),
            radioButtonUPS.heightAnchor.constraint(equalToConstant: 35),
            
            radioButtonDHL.topAnchor.constraint(equalTo: radioButtonUPS.bottomAnchor, constant: 5),
            radioButtonDHL.leadingAnchor.constraint(equalTo: radioButtonUPS.leadingAnchor),
            radioButtonDHL.widthAnchor.constraint(equalToConstant: 35),
            radioButtonDHL.heightAnchor.constraint(equalToConstant: 35),
            
            labelUPS.centerYAnchor.constraint(equalTo: radioButtonUPS.centerYAnchor),
            labelUPS.leadingAnchor.constraint(equalTo: radioButtonUPS.trailingAnchor, constant: 5),
            labelUPS.trailingAnchor.constraint(equalTo: shippingContentView.trailingAnchor, constant: -20),
            labelUPS.heightAnchor.constraint(equalToConstant: 23),
            
            labelDHL.centerYAnchor.constraint(equalTo: radioButtonDHL.centerYAnchor),
            labelDHL.leadingAnchor.constraint(equalTo: radioButtonDHL.trailingAnchor, constant: 5),
            labelDHL.trailingAnchor.constraint(equalTo: shippingContentView.trailingAnchor, constant: -20),
            labelDHL.heightAnchor.constraint(equalToConstant: 23),
            
            buttonCart.topAnchor.constraint(equalTo: shippingContentView.bottomAnchor, constant: 20),
            buttonCart.leadingAnchor.constraint(equalTo: shippingContentView.leadingAnchor),
            buttonCart.trailingAnchor.constraint(equalTo: shippingContentView.centerXAnchor, constant: -5),
            buttonCart.heightAnchor.constraint(equalToConstant: 50),
            
            buttonCheckout.leadingAnchor.constraint(equalTo: shippingContentView.centerXAnchor, constant: 5),
            buttonCheckout.topAnchor.constraint(equalTo: buttonCart.topAnchor),
            buttonCheckout.trailingAnchor.constraint(equalTo: shippingContentView.trailingAnchor),
            buttonCheckout.heightAnchor.constraint(equalToConstant: 50)

        ])
        productImage.startAnimatingActivity()
        
        
    }
    
    @objc func pressedDone() {
        self.dismiss(animated: true)
    }
    
    
    
    

    

}

extension ProductDetailsVC: RadioButtonDelegate {
    func onClick(_ sender: UIView) {
        guard let radioButton = sender as? RadioButton, !radioButton.isSelected else {
            let radio = sender as? RadioButton
            radio?.animateCurrentState()
            return
        }
        radioButtonUPS.changeState()
        radioButtonDHL.changeState()
        
    }
}
