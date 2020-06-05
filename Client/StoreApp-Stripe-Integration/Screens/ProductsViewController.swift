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
    let refreshControl = UIRefreshControl()
    var doneFirstLoad: Bool = false
    
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
                self.productDataSource.removeAll()
                self.productDataSource = products
                self.refreshCollectionView()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func configureNavBar() {
        let rightItem = UIBarButtonItem(image: UIImage(systemName: SFSymbols.avatarImage), style: .plain, target: self, action: #selector(profileSelected))
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
        refreshControl.addTarget(self, action: #selector(self.refreshProducts), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh products", attributes: nil)
        refreshControl.tintColor = .systemBlue
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
        
    }
    
    
    @objc func profileSelected() {
        displayAlertOnMainThread(for: .custom, autoHide: true, title: "Not yet implemented 😔")
    }
    
    
    @objc func refreshProducts() {
        getProductsData()
    }
    
    
    private func refreshCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            guard self.doneFirstLoad else {
                self.doneFirstLoad.toggle()
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.refreshControl.endRefreshing() }
        }
    }
    
}

//MARK: - CollectionView DataSource
extension ProductsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = productDataSource[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.tag = indexPath.row
        cell.set(with: product, for: indexPath)
        return cell
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
