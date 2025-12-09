//
//  ContentView.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 07.12.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var coinVM = CoinViewModel()
    @State private var searchText = ""
    var filteredCoins: [Coin] {
        // 1. Если поиск пустой — возвращаем весь список
        if searchText.isEmpty {
            return coinVM.coins
        }
        
        // 2. Иначе фильтруем: ищем совпадение в имени
        return coinVM.coins.filter({coin in
            coin.name.localizedCaseInsensitiveContains(searchText)
        })
    }
    var body: some View {
        NavigationStack{
            List(filteredCoins){ coin in
                HStack{
                    CoinRow(coin: coin)
                }
            }
            .navigationTitle("Crypto Market")
            .onAppear(perform: coinVM.fetchCoins)
            .searchable(text: $searchText, prompt: "Найти монету")
        }
    }
}

#Preview {
    ContentView()
}
