//
//  LLBodyLabel.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 03/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class LLBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        configure()
    }
    
    
    convenience init(fontSize: CGFloat, fontColor: UIColor) {
        self.init(fontSize: fontSize)
        textColor = fontColor
    }
    
    convenience init(fontSize: CGFloat, fontColor: UIColor, weight: UIFont.Weight) {
        self.init(fontSize: fontSize)
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        textColor = fontColor
    }
    
    
    private func configure(){
        numberOfLines = 12
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        self.sizeToFit()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
