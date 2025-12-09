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
                Text("\(coin.price, specifier: "%.2f") $")
                    .bold()
                Text("\(coin.change, specifier: "%.2f")%")
                    .foregroundStyle(coin.change >= 0 ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    // Создаем фейковую монету руками
    CoinRow(coin: Coin(
        id: "bitcoin",
        logo: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        name: "Bitcoin",
        price: 45000.00,
        change: 2.5
    ))
}
