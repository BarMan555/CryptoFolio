//
//  Portfolio.swift
//  CryptoFolio
//
//  Created by Борис Шестериков on 14.12.2025.
//

import SwiftUI

struct Portfolio: View {
    @Environment(CoinViewModel.self) private var coinVM: CoinViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Portfolio()
}
