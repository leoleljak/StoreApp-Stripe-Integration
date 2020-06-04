//
//  LLCentralAlertVC.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 04/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class LLCentralAlertVC: UIViewController {
    
    let containerView = UIView(frame: .zero)
    let imageView = UIImageView(frame: .zero)
    let titleLabel = LLTitleLabel(fontSize: 20, fontColor: .label)
    var vcToDismiss: UIViewController?
    var currentType: AlertType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        scheduleDismissSelf()
        layoutUI()
    }
    
    
    private func scheduleDismissSelf() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }
    
    private func configure() {
        view.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 20
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    @objc func fireTimer() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            self.currentType == AlertType.success ? self.vcToDismiss?.dismiss(animated: true, completion: nil) : nil
        }
    }
    
    
    
    
    
    private func layoutUI() {
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            containerView.widthAnchor.constraint(equalToConstant: 250),
            
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 23)
            
        ])
        
        
        
        
    }
    
    
    #warning("Refaktorirati u konstante")
    func set(type: AlertType ) {
        currentType = type
        
        switch type {
        case .success:
            imageView.image = UIImage(systemName: "checkmark")
            titleLabel.text = "Payment Suceedded"
            imageView.tintColor = .systemGreen
        case .error:
            imageView.image = UIImage(systemName: "xmark")
            titleLabel.text = "Payment Failed"
            imageView.tintColor = .systemRed
        }
    }
    
    
}

enum AlertType {
    case success, error
}
