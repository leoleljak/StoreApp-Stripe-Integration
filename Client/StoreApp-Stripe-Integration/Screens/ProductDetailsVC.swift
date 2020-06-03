//
//  ProductDetailsVC.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    let productImage = ProductImage(frame: .zero)
    let scrollView = UIScrollView(frame: .zero)
    let contentView = UIView(frame: .zero)
    let titleLabel = LLTitleLabel(fontSize: 30, fontColor: .systemBlue)
    let bodyLabel = LLBodyLabel(fontSize: 15, fontColor: .secondaryLabel)
    let priceLabel = LLBodyLabel(fontSize: 20, fontColor: .systemGray, weight: .bold)
   
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configure()
        layoutUI()
        fillData()
        
    }
    
    
    func configure() {
        title = product.name
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let barItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(pressedDone))
        navigationItem.rightBarButtonItem = barItem
        productImage.changeActivityIndicatorColor(to: .blue)
        
        priceLabel.textColor = .systemGreen
    }
    
    
    func fillData() {
        productImage.setPicture(fromUrl: product.imageUrl)
        titleLabel.text = product.name
        bodyLabel.text = "This is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database his is product description that needs to be replaced as soon as one is available on Database"
        priceLabel.text = "\(product.price)\(product.currency.rawValue) "
    }
    
    
    func layoutUI() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(productImage)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(priceLabel)
        
        
        
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
            priceLabel.heightAnchor.constraint(equalToConstant: 23)

        ])
        productImage.startAnimatingActivity()
        
    }
    
    @objc func pressedDone() {
        self.dismiss(animated: true)
    }
    
    
    
    

    

}
