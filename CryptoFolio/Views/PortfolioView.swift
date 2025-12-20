//
//  Portfolio.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 14.12.2025.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(CoinViewModel.self) private var coinVM: CoinViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    // Здесь будет красивая карточка баланса, но пока заглушка
                    Text("Баланс Портфолио: $0.00")
                        .font(.title2)
                        .bold()
                        .padding()
                    
                    // 👨‍🏫 УЧИТЕЛЬ:
                    // Смотри, мы снова используем CoinRow!
                    // Нам не нужно писать код верстки монеты заново.
                    // DRY - Don't Repeat Yourself (Не повторяйся).
                    // Пока выведем все монеты, чтобы проверить связь.
                    ForEach(coinVM.coins) { coin in
                         CoinRow(coin: coin)
                    }
                }
            }
            .navigationTitle("Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Add button tapped")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    Portfolio()
        .environment(CoinViewModel())
}
