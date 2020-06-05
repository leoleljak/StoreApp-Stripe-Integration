//
//  LLCentralAlertVC.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 04/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

enum AlertType {
    case success, error, custom
}


protocol LLCentralAlertVCDelegate: class {
    func onCompletionOfDismissingAlert(for type: AlertType)
}


class LLCentralAlertVC: UIViewController {
    let containerView = UIView(frame: .zero)
    let imageView = UIImageView(frame: .zero)
    let titleLabel = LLTitleLabel(fontSize: 20, fontColor: .label, numberOfLines: 2)
    weak var delegate: LLCentralAlertVCDelegate?
    var currentType: AlertType?
    
    var autoHide: Bool = true
    var customText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        scheduleDismissSelf()
        layoutUI()
    }

    
    convenience init(autoHide: Bool?, title: String?, alertType: AlertType) {
        self.init()
        if let autohide = autoHide {self.autoHide = autohide}
        customText = title
        currentType = alertType
    }
    
    
    convenience init(alertType: AlertType) {
        self.init()
        currentType = alertType
        
    }
    
    
    private func scheduleDismissSelf() {
        guard autoHide == true else {
            return
        }
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }
    
    
    private func configure() {
        view.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 20
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSelf)))
    }
    
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func fireTimer() {
        guard let currentAlertType = self.currentType, let delegateVC = self.delegate else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        DispatchQueue.main.async { self.dismiss(animated: true) { delegateVC.onCompletionOfDismissingAlert(for: currentAlertType) }}
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
    
    
    func set(type: AlertType ) {
        currentType = type
        
        switch type {
        case .success:
            imageView.image = UIImage(systemName: SFSymbols.success)
            titleLabel.text = Constants.paymentSuccess
            imageView.tintColor = .systemGreen
        case .error:
            imageView.image = UIImage(systemName: SFSymbols.error)
            titleLabel.text = Constants.paymentFailed
            imageView.tintColor = .systemRed
        case .custom:
            imageView.image = UIImage(systemName: SFSymbols.error)
            titleLabel.text = self.customText
            imageView.tintColor = .systemRed
        }
    }
    
    
}
