//
//  CoinViewModel.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 07.12.2025.
//

import Foundation

@Observable
class CoinViewModel{
    var coins: [Coin] = []
    
    func fetchCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24h")
        else {return}
            
        URLSession.shared.dataTask(with: url){
            data, response, error in
            if error != nil{
                print("Error fetching data: \(error!.localizedDescription)")
                return
            }
            
            // Шаг 1: Достаем httpResponse
            guard let httpResponse = response as? HTTPURLResponse else { return }

            // Шаг 2: Проверяем статус (теперь httpResponse нам доступен!)
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Bad server responce: \(httpResponse.statusCode)")
                return
            }
            
            do {
                guard let data = data else {return}
                let decodedData = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async{
                    self.coins = decodedData
                }
            }catch{
                print("Error decoding: \(error)")
            }
        }.resume()
    }
}
