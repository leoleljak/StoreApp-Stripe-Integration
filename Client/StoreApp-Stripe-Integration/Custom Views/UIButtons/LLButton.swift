//
//  LLButton.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 03/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import UIKit

class LLButton: UIButton {

    override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
           
       }
       
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       init(backgroundColor: UIColor, title: String){
           super.init(frame: .zero)
           self.backgroundColor = backgroundColor
           self.setTitle(title, for: .normal)
           configure()
           
       }
       
       
       func set(backgroundColor: UIColor, title: String){
           self.backgroundColor = backgroundColor
           setTitle(title, for: .normal)
       }
       
       
       private func configure(){
           layer.cornerRadius = 15
           setTitleColor(.white, for: .normal)
           titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
           translatesAutoresizingMaskIntoConstraints = false
        
       }

}
