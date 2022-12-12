//
//  Saldo.swift
//  ChallengeBRQ
//
//  Created by Gustavo Hossein on 31/10/22.
//

//MARK: - Wallet
class Money {
    var balance: Double
    var cash: [String: Int]
    
    init() {
        balance = 1000.00
        cash = ["USD": 0, "EUR": 0, "GBP": 0, "ARS": 0, "CAD": 0]
    }
    
    func acao(amount: Int, tag: String, value: Double, senderTag: Int) -> Double {
        guard let balanceCoin = cash[tag] else {
            return 0.0
        }
        if senderTag == 0 {
                   
            let totalValueSell = value * Double(amount)
                   
            balance += totalValueSell
            cash[tag] = balanceCoin - amount
            
            return totalValueSell
        } else {
                    
            let totalValueBuy = value * Double(amount)
                    
            cash[tag] = balanceCoin + amount
            balance -= totalValueBuy
            
            return totalValueBuy
        }
    }
}
