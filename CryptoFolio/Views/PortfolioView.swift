//
//  Portfolio.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 14.12.2025.
//

import SwiftUI
import SwiftData

struct PortfolioView: View {
    // 1. Достаем ViewModel (чтобы знать текущие цены)
    @Environment(CoinViewModel.self) var coinVM: CoinViewModel
    
    // 2. Достаем список сохраненных монет из базы
    @Query var portfolioCoins: [PortfolioItem]
    
    @Environment(\.modelContext) private var context
    
    @State private var showedEditPortfolio: Bool = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    // Карточка баланса
                    Text("Портфолио")
                        .font(.title2)
                        .bold()
                        .padding([.top, .horizontal])
                    
                    if portfolioCoins.isEmpty {
                        Text("У вас пока нет активов. Нажмите +, чтобы добавить.")
                            .foregroundStyle(.secondary)
                            .padding()
                    }else{
                        ForEach(portfolioCoins){ item in
                            if let coin = coinVM.coins.first(where: {$0.id == item.coinId}){
                                PortfolioRow(coin: coin, item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showedEditPortfolio.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showedEditPortfolio) {
            EditPortfolioView()
                .environment(coinVM)
        }
    }
}


struct PortfolioRow: View {
    let coin: Coin
    let item: PortfolioItem
    
    var body: some View {
        HStack {
            // Логотип и имя (используем твой готовый CoinRow или упрощаем)
            CoinRow(coin: coin)
            
            Spacer()
            
            // Информация о наших активах
            VStack(alignment: .trailing) {
                // Текущая стоимость наших монет (Цена * Количество)
                Text("$\(coin.currentPrice * item.amount, specifier: "%.2f")")
                    .bold()
                
                // Сколько штук у нас есть
                Text("\(item.amount, specifier: "%.2f") \(coin.symbol.uppercased())")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    PortfolioView()
        .environment(CoinViewModel())
}
