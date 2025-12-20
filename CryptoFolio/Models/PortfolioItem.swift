//
//  PortfolioItem.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 20.12.2025.
//

import Foundation
import SwiftData

@Model
class PortfolioItem{
    var coinId: String
    var amount: Double
    
    init(coinId: String, amount: Double) {
        self.coinId = coinId
        self.amount = amount
    }
}
