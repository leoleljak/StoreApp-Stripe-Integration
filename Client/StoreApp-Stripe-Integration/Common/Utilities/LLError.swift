//
//  LLError.swift
//  StoreApp-Stripe-Integration
//
//  Created by Leo Leljak on 03/06/2020.
//  Copyright © 2020 Leo Leljak. All rights reserved.
//

import Foundation

enum LLNetworkError: String, Error {
    case networkFailure = "Problem with network, it seems internet is off"
    case invalidURL = "Invalid URL, can't convert to URL"
    case invalidResponseServer = "Invalid response from server."
    case invalidData = "The data received from server are invalid"
    case decodingFailure = "Problem in decoding data from server"
}
