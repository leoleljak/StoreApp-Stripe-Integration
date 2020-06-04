//
//  ProductCollectionViewCell.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let reuseID = "ProductCell"
    var productImageView = ProductImage(frame: .zero)
    var nameLabel = LLTitleLabel(fontSize: 16, fontColor: .white)
    var priceLabel = LLTitleLabel(fontSize: 16, fontColor: .white)
    let stackView = UIStackView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        priceLabel.text = ""
        nameLabel.text = ""
        
    }
    
    
    func set(with product: Product, for indexPath:IndexPath) {
        self.nameLabel.text = product.name
        self.priceLabel.text = "\(product.price)€"
        self.productImageView.startAnimatingActivity()
        
        NetworkManager.shared.downloadPicture(fromUrl: product.imageUrl) { (image) in
            guard let image = image else { return }
            if (self.tag == indexPath.row) {
                self.productImageView.image = image
                self.productImageView.stopAnimatingActivity()
            }
        }
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func layoutUI() {
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 15
        
        addSubview(productImageView)
        addSubview(stackView)
        
        let padding: CGFloat = 7
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: -30),
            
            stackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 20),
        ])
        productImageView.configureActivityIndicator()
    }
    
    
}
