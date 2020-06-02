//
//  ProductsViewController.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    var collectionView: UICollectionView!
    var productDataSource = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureCollectionView()
        getProductsData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProductsData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func getProductsData() {
        NetworkManager.shared.getProducts { result in
            switch result {
            case .success(let products):
                self.productDataSource = products
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func configureNavBar() {
        let rightItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.avatarImage), style: .plain, target: self, action: #selector(avatarSelected))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(for: self.view))
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
 
    }
    
    
    @objc func avatarSelected() {
        print("Dummy Avatar Selected")
    }
    

}

//MARK: - CollectionView DataSource
extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell
        cell?.productImageView.image = nil
        cell?.productImageView.startAnimatingActivity()
        
        let product = productDataSource[indexPath.row]
        cell?.nameLabel.text = product.name
        cell?.priceLabel.text = "\(product.price)€"
        cell?.productImageView.setPicture(fromUrl: product.imageUrl)

        return cell!
    }
    
}


//MARK: - CollectionView Delegate
extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productDataSource[indexPath.row]
        
        let productDetailVC = ProductDetailsVC()
        productDetailVC.product = product
        let navigationVC = UINavigationController(rootViewController: productDetailVC)
        present(navigationVC, animated: true)
        
    }
}
