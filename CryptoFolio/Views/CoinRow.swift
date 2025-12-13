//
//  CoinView.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 07.12.2025.
//

import SwiftUI
import Kingfisher

struct CoinRow: View {
    let coin: Coin
    
    var body: some View {
        HStack{
            KFImage(URL(string: coin.logo))
                .placeholder{
                    ProgressView()
                }
                .fade(duration: 0.25) // Плавное появление
                .resizable()
                .frame(width: 30, height: 30)
                //.clipShape(Circle())
                .scaledToFit()
            
            Text(coin.name)
                .font(Font.headline)
            
            Spacer()
            
            VStack {
                Text("\(coin.currentPrice, specifier: "%.2f") $")
                    .bold()
                Text("\(coin.priceChangePercentage24h ?? 0, specifier: "%.2f")%")
                    .foregroundStyle(coin.priceChangePercentage24h ?? 0 >= 0 ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CoinRow(coin: Coin.example)
}
