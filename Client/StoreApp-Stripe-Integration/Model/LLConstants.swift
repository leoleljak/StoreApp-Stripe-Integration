//
//  LLConstants.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation

//MARK: - SFSymbols Strings
enum SFSymbols {
    static let store = "bag"
    static let cart = "cart"
    static let storeFilled = "bag.fill"
    static let cartFilled = "cart.fill"
    static let avatarImage = "person.crop.circle"
    static let success = "checkmark"
    static let error = "xmark"
    
}

//MARK: - Constants
enum Constants {
    static let storeTitle = "Store"
    static let cartTitle = "Cart"
    static let API_URL = "http://192.168.1.8/api/"
    static let API_KEY = "REPLACE WITH STRIPE PUBLISHABLE API KEY"
    
    static let paymentSuccess = "Payment Suceedded"
    static let paymentFailed = "Payment Failed"
}

enum RadioStates: String{
    case radioChecked, radioUnchecked
}

enum ReuseIdentifiers {
    static let productCell = "ProductCell"
}





