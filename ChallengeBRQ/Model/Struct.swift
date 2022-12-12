//
//  Struct.swift
//  ChallengeBRQ
//
//  Created by Gustavo Hossein on 31/10/22.
//

//MARK: - API structure
struct Welcome: Codable {
    let results: Results
}

struct Results: Codable {
    let currencies: Currencies
}

struct Currencies: Codable {
    let USD, EUR, GBP, ARS, CAD, AUD, JPY, CNY, BTC: IdCoins
}

struct IdCoins: Codable {
    let name: String
    let buy: Double
    let sell: Double?
    let variation: Double
}
