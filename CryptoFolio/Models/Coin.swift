//
//  Coin.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 07.12.2025.
//

import Foundation

import Foundation

// MARK: - Coin Model
struct Coin: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let logo: String
    let currentPrice: Double
    let priceChangePercentage24h: Double?
    
    let marketCap: Double?
    let marketCapRank: Int?
    let totalVolume: Double?
    let high24h: Double?
    let low24h: Double?
    let sparklineIn7D: SparklineIn7D?
    
    struct SparklineIn7D: Codable {
        let price: [Double]
    }
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case logo = "image"
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case sparklineIn7D = "sparkline_in_7d"
    }
}

extension Coin {
    static var example: Coin {
        Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            logo: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
            currentPrice: 48000.00,
            priceChangePercentage24h: 1.25,
            marketCap: 900000000000,
            marketCapRank: 1,
            totalVolume: 35000000000,
            high24h: 49000.00,
            low24h: 47000.00,
            sparklineIn7D: SparklineIn7D(price: [
                48000, 47000, 49500, 47800, 47500, 48100, 49000, 48000 // Пример данных графика
            ])
        )
    }
}
