//
//  Coin.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 07.12.2025.
//

import Foundation

struct Coin: Identifiable, Codable{
    let id: String
    let logo: String
    let name: String
    var price: Double
    var change: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case logo = "image"
        case name
        case price = "current_price"
        case change = "price_change_percentage_24h"
    }
}
