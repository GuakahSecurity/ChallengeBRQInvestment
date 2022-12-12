//
//  RequisicaoApi.swift
//  ChallengeBRQ
//
//  Created by Gustavo Hossein on 21/11/22.
//

import Foundation

extension ViewController {
    
    // MARK: - Dados
    @objc func loadCoins() {
        guard let url = URL(string: urlString) else {
            print("Error in URL: \(urlString)")
            return
        }
        //MARK: - Consumo da API
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(Welcome.self, from: data)

                    self.coins.append(parsedJSON.results.currencies.USD)
                    self.coins.append(parsedJSON.results.currencies.EUR)
                    self.coins.append(parsedJSON.results.currencies.GBP)
                    self.coins.append(parsedJSON.results.currencies.ARS)
                    self.coins.append(parsedJSON.results.currencies.CAD)

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Erro 11")
                }
            }
        }.resume()
    }

}
