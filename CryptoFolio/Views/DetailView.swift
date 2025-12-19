//
//  DetailView.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 09.12.2025.
//

import SwiftUI
import Charts
import Kingfisher

struct DetailView: View {
    let coin: Coin
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            VStack{
                // 1. Header
                headerSection
                
                // 2. Chart
                chartSection
                
                // 3. Statistic block
                statsSection
            }
            .padding(.top)
        }
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 1. Header Section
extension DetailView {
    private var headerSection: some View {
        VStack {
            // 1. Блок: Логотип и Название
            HStack{
                KFImage(URL(string: coin.logo))
                        .placeholder{
                            ProgressView()
                        }
                        .fade(duration: 0.25)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        //.clipShape(Circle())
                        .shadow(radius: 5)
                        .padding(10)
                
                Text(coin.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
            }
            
            
            // 2. Блок: Цена
            Text("$\(coin.currentPrice, specifier: "%.2f")")
                .font(.system(size: 40, weight: .heavy, design: .rounded))
        }
    }
}

// 2. Chart Section
extension DetailView {
    private var chartSection: some View {
        VStack(spacing: 15) {
            Text("7 Day Trend")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            
            
            // Проверка: "Если у нас получилось достать массив цен, называем его data"
            if let data = coin.sparklineIn7D?.price {
                
                // 0. Определяем цвет линии (зеленый или красный)
                let lineColor = (coin.priceChangePercentage24h ?? 0) >= 0 ? Color.green : Color.red
                
                Chart {
                    // 2. Перебираем данные с индексами
                    ForEach(Array(data.enumerated()), id: \.offset) { index, price in
                        
                        // Рисуем Линию
                        LineMark(
                            x: .value("Index", index),
                            y: .value("Price", price)
                        )
                        .interpolationMethod(.catmullRom) // Делает линию плавной и изогнутой
                        .foregroundStyle(lineColor)
                        
                        // (Дополнительно) Рисуем закрашенную область под линией для красоты
                        AreaMark(
                            x: .value("Index", index),
                            yStart: .value("Min", data.min() ?? 0),
                            yEnd: .value("Price", price)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [lineColor.opacity(0.3), lineColor.opacity(0)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                }

                // 2. Настройка масштаба (чтобы график не лип к краям)
                .chartYScale(domain: (data.min() ?? 0)...(data.max() ?? 0))
                // 3. Срываем оси координат (для стиля "sparkline")
                .chartXAxis(.hidden)
                // Добавляем линии сетки
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        // Рисуем только горизонтальные линии (GridMark)
                        AxisGridLine()
                            .foregroundStyle(Color.gray.opacity(0.3)) // Делаем их очень тонкими и светлыми
                    }
                }
                // 4. Задаем высоту
                .frame(height: 200)
            }
        }
        .padding()
        .background(Color.primary.opacity(0.03))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}

extension DetailView{
    private var statsSection: some View{
        LazyVGrid(columns: columns, alignment: .leading, spacing: 30) {
            // РЯД 1
            StatisticView(title: "Market Cap Rank", value: "\(coin.marketCapRank ?? 0)")
            StatisticView(title: "Market Cap", value: "$" + (coin.marketCap?.formatted() ?? "n/a"))
            
            // РЯД 2
            StatisticView(title: "High (24h)", value: "$" + (coin.high24h?.formatted() ?? "n/a"))
            StatisticView(title: "Low (24h)", value: "$" + (coin.low24h?.formatted() ?? "n/a"))
            
            // РЯД 3
            StatisticView(title: "Volume (24h)", value: "$" + (coin.totalVolume?.formatted() ?? "n/a"))
        }
        .padding()
        .background(Color.primary.opacity(0.03))
        .cornerRadius(20)
        .padding(.horizontal)
    }
}

struct StatisticView : View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    DetailView(coin: Coin.example)
}
