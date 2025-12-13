//
//  CoinView.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 07.12.2025.
//

import SwiftUI

struct CoinRow: View {
    let coin: Coin
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: coin.logo)) { image in
                image.resizable() // Разрешаем менять размер картинки
            } placeholder: {
                ProgressView()
            }
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            
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
