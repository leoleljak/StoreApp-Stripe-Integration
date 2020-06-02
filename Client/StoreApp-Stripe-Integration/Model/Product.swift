//
//  Product.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 02/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation


struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
    let currency: Currency
    let imageUrl: String
}

enum Currency:String, Codable {
    case HRK
    case USD
    case EUR
}
