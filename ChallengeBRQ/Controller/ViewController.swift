//
//  ViewController.swift
//  ChallengeBRQ
//
//  Created by Gustavo Hossein on 29/10/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    var tagCoins = ["USD", "EUR", "GBP", "ARS", "CAD"]
    var coins = [IdCoins]()
    var money = Money()

    let urlString = "https://api.hgbrasil.com/finance"

    let Number: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.currencyCode = "BRL"
        return formatter
    }()

    let cellHeight: CGFloat = 85

    // MARK: - Outlet TableView
    @IBOutlet var tableView: UITableView!

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        title = "Moedas"

        definirButtonRefresh()
        loadCoins()
    }
    
    // MARK: Button Refresh
    func definirButtonRefresh() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadCoins))
        refresh.tintColor = .white
        refresh.accessibilityLabel = "Refresh"
        
        navigationItem.rightBarButtonItem = refresh
    }
}


//MARK: - Extensão da TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagCoins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CoinViewCell else {
            return UITableViewCell()
        }
        cell.isAccessibilityElement = true
        cell.accessibilityHint = " Acessar o câmbio "

        // Sigla da moeda
        cell.coinLabel.text = tagCoins[indexPath.row]
        if indexPath.row >= 0 && indexPath.row < coins.count {
            cell.coinLabel.accessibilityLabel = coins[indexPath.row].name

            // Variação da moeda
            if let variation = coins[indexPath.row].variation as NSNumber? {
                if let varString = Number.string(from: variation) {
                    cell.variationLabel.text = varString + "%"
                }
            }
            cell.variationLabel.colorVariation(coins[indexPath.row].variation)
        }
        cell.coinView.borderView()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    //MARK: - Transição para a tela Cambio + Dados
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storyboard = storyboard,
              let navigation = navigationController
        else { return }

        if let cambioVC = storyboard.instantiateViewController(withIdentifier: "cambioVC") as? CambioViewController {
            cambioVC.tagCoins = tagCoins[indexPath.row]
            cambioVC.coins = coins[indexPath.row]
            cambioVC.money = money
            cambioVC.NumberFormatter = Number
            navigation.pushViewController(cambioVC, animated: true)
        }
    }
}
