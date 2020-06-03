//
//  RadioButton.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 03/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

protocol RadioButtonDelegate {
    func onClick(_ sender: UIView)
}


class RadioButton: UIControl, RadioButtonDelegate {
    
    var radioImage = UIImageView()
    var delegate: RadioButtonDelegate?
    
    @objc func onClick(_ sender: UIView) {
        delegate?.onClick(self)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    convenience init(for status: RadioStates) {
        self.init(frame: .infinite)
        layoutImage()
        configure(for: status)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func changeState() {
        isSelected.toggle()
        
        if isSelected {
            animateCurrentState()
            feedbackSelection()
            
        }else {
            radioImage.image = UIImage(named: RadioStates.radioUnchecked.rawValue)
            feedbackSelection()
        }
    }
    
    
    func animateCurrentState() {
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            
            
            self.radioImage.image = UIImage(named: RadioStates.radioChecked.rawValue)
        }
    }
    
    
    private func feedbackSelection() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    
    private func configure(for status: RadioStates) {
        self.translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        radioImage.image = UIImage(named: status.rawValue)
        
    }
    
    
    private func layoutImage() {
        addSubview(radioImage)
        radioImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            radioImage.topAnchor.constraint(equalTo: self.topAnchor),
            radioImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            radioImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            radioImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    
    
    
}
