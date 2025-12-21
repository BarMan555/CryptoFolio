//
//  EditPortfolioView.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 20.12.2025.
//

import SwiftUI
import SwiftData

struct EditPortfolioView: View {
    @Environment(CoinViewModel.self) var coinVM
    
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) private var context
    @Query private var portfolioCoins: [PortfolioItem]
    
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack {
                    // 1. Поле ввода (Появляется только если монета выбрана)
                    if let coin = selectedCoin {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Сколько \(coin.symbol.uppercased()) у вас есть?")
                                .font(.headline)
                            
                            // Поле для цифр
                            TextField("Например: 1,5", text: $quantityText)
                                .keyboardType(.decimalPad) // Только цифры и точка
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        .padding()
                        .animation(.easeInOut, value: selectedCoin) // Плавное появление
                    }
                    
                    // 2. Список монет для выбора
                    Text("Выберите монету")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                        .padding(selectedCoin == nil ? [.top, .horizontal] : .horizontal)
                    
                    // Используем filteredCoins из ViewModel, если есть поиск,
                    // или просто весь список vm.coins
                    ForEach(coinVM.coins) { coin in
                        CoinRow(coin: coin)
                        // Делаем строку "нажимаемой"
                            .onTapGesture {
                                withAnimation {
                                    updateSelectedCoin(coin: coin)
                                }
                            }
                        // Красим фон, если монета выбрана
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedCoin?.id == coin.id ? Color.green : Color.clear, lineWidth: 2)
                            )
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Добавить актив")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Сохранить") {
                        saveButtonPressed()
                    }
                    // Кнопка неактивна, если ничего не выбрано или поле пустое
                    .disabled(selectedCoin == nil || quantityText.isEmpty)
                    .opacity(selectedCoin != nil && !quantityText.isEmpty ? 1.0 : 0.3)
                }
            }
        }
    }
    
    // Логика выбора монеты
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        // Сюда можно добавить логику: если монета уже есть в портфеле,
        // подставить текущее количество в поле ввода.
    }

    // Логика сохранения
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        if let existingItem = portfolioCoins.first(where: {$0.coinId == coin.id}){
            // 1. Обновляем старое значение amount
            existingItem.amount = amount
        }else{
            // 1. Создаем объект для базы данных
            let newItem = PortfolioItem(coinId: coin.id, amount: amount)
            // Сохраняем в БД
            context.insert(newItem)
        }
        
        // 2. Закрываем шторку
        dismiss()
    }
}



#Preview {
    EditPortfolioView()
        .environment(CoinViewModel())
}
