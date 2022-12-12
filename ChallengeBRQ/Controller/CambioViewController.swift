//
//  CambioViewController.swift
//  ChallengeBRQ
//
//  Created by Gustavo Hossein on 30/10/22.
//

import UIKit

class CambioViewController: UIViewController {
    
    //MARK: - Info Coins
    @IBOutlet var cambioView: UIView!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var variationLabel: UILabel!
    @IBOutlet var buyLabel: UILabel!
    @IBOutlet var sellLabel: UILabel!
    
    // MARK: - Exchange data
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var cashLabel: UILabel!
    @IBOutlet var amountTextField: UITextField!
    
    // MARK: - Buttons
    @IBOutlet var sellButton: UIButton!
    @IBOutlet var buyButton: UIButton!
    
    
    var tagCoins: String?
    var coins: IdCoins?
    var money: Money?
    var NumberFormatter: NumberFormatter?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Câmbio"
        
        setBorder()
        loadCoins()
        checkButton()
    }
    
    // MARK: - Layout
    func setBorder() {
        cambioView.borderView()
        
        amountTextField.setBorderTextField()
        amountTextField.setPadding()
        amountTextField.setPlaceholder()
        
        sellButton.setBorderButton()
        buyButton.setBorderButton()
    }
    
    // MARK: - Load Data
    func loadCoins() {
        guard let coins = coins,
              let money = money,
              let tagCoins = tagCoins,
              let NumberFormatter = NumberFormatter
        else { return }
        
        tagLabel.text = "\(tagCoins) - \(coins.name)"
        
        if let variation = coins.variation as NSNumber? {
            if let varString = NumberFormatter.string(from: variation) {
                variationLabel.text = varString + "%"
            }
        }
        variationLabel.colorVariation(coins.variation)
        
        if let buy = coins.buy as NSNumber? {
            if let buyString = NumberFormatter.string(from: buy) {
                buyLabel.text = "Compra: R$ \(buyString)"
            }
        }
        
        if let sell = coins.sell as NSNumber? {
            if let sellString = NumberFormatter.string(from: sell) {
                sellLabel.text = "Venda: R$ \(sellString)"
            }
        }
        
        if let balance = money.balance as NSNumber? {
            if let balanceString = NumberFormatter.string(from: balance) {
                balanceLabel.text = "Saldo disponível: R$ \(balanceString)"
            }
        }
        
        if let cash = money.cash[tagCoins] as NSNumber? {
            if let cashString = NumberFormatter.string(from: cash) {
                cashLabel.text = "\(cashString) \(coins.name) em caixa"
            }
        }
        amountTextField.text = String()
        amountTextField.accessibilityHint = "Digite a quantidade"
    }
    
    // MARK: - enableButton
    func enableButton(_ button: UIButton) {
        button.isEnabled = true
        button.alpha = 1
    }
    
    // MARK: - disableButton
    func disableButton(_ button: UIButton) {
        button.isEnabled = false
        button.alpha = 0.5
    }
    
    //MARK: - Checar o botão 
    func checkButton() {
        guard let coins = coins,
              let money = money,
              let tagCoins = tagCoins,
              let amountText = amountTextField.text
        else { return }
        
        var amount: Int = 0
        
        if let amountInt = Int(amountText) {
            amount = amountInt
        }
        // MARK: - Sell coin
        if let cash = money.cash[tagCoins] {
            if cash < amount || cash == 0 || coins.sell == nil {
                disableButton(sellButton)
            } else {
                enableButton(sellButton)
            }
        }
        // MARK: - Buy coin
        let totalValueBuy = coins.buy * Double(amount)
        
        if money.balance < totalValueBuy || money.balance < coins.buy {
            disableButton(buyButton)
        } else {
            enableButton(buyButton)
        }
        
        if amountText.isEmpty || amount <= 0 {
            disableButton(sellButton)
            disableButton(buyButton)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        loadCoins()
        checkButton()
    }
    
    // MARK: - Check amount
    @IBAction func amountCheck(_ sender: UITextField) {
        checkButton()
    }
    
    @IBAction func buttonFunctionality(_ sender: UIButton) {
        guard let coins = coins,
              let money = money,
              let tagCoins = tagCoins,
              let numberFormatter = NumberFormatter,
              let amountText = amountTextField.text,
              let amount = Int(amountText),
              
              let storyboard = storyboard,
              let navigation = navigationController,
              
              let transactionVC = storyboard.instantiateViewController(withIdentifier: "transactionVC") as? TransactionViewController
                
        else { return }
        
        var transaction = String()
        var totalTransaction = Double()
        
        if sender.tag == 0 {
            guard let sellValue = coins.sell else { return }
            
            totalTransaction = money.acao(amount: amount, tag: tagCoins, value: sellValue, senderTag: sender.tag)
            transaction = "vender"
            
        } else {
            let buyValue = coins.buy
            
            totalTransaction = money.acao(amount: amount, tag: tagCoins,value: buyValue, senderTag: sender.tag)
            transaction = "comprar"
        }
        transactionVC.title = transaction.capitalized
        transactionVC.transactionMessage = transaction
        transactionVC.amountMessage = amount
        transactionVC.tagCoinsMessage = tagCoins
        transactionVC.coinsMessage = coins
        transactionVC.totalTransactionMessage = totalTransaction
        navigation.pushViewController(transactionVC, animated: true)
    }
}
