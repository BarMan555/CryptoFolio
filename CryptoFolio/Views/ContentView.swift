//
//  ContentView.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 13.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var coinVM = CoinViewModel()
    
    var body: some View {
        TabView {
            // Вкладка 1: Рынок
            HomeView()
                .tabItem {
                    Image(systemName: "bitcoinsign.circle.fill")
                    Text("Live Prices")
                }
            
            // Вкладка 2: Портфолио
            Portfolio()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Portfolio")
                }
        }
        // Меняем цвет иконок меню на зеленый
        .tint(.green)
        // DI model view в наше приложение
        .environment(coinVM)
    }
}

#Preview {
    ContentView()
}
