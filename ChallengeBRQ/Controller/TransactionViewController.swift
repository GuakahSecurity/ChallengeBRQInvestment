//
//  TransactionViewController.swift
//  ChallengeBRQ
//
//  Created by Gustavo Hossein on 03/11/22.
//

import UIKit

class TransactionViewController: UIViewController {
    
    var transactionMessage : String = ""
    var amountMessage : Int = 0
    var tagCoinsMessage : String = ""
    var coinsMessage : IdCoins?
    var totalTransactionMessage : Double = 0.0
    
    var totalTransaction: String {

           let Number = NumberFormatter()
               Number.numberStyle = .currency
               Number.currencyCode = "BRL"
           if let result = Number.string(from: NSNumber(value: totalTransactionMessage)) {
               return result
           }
           return "R$0.00"
       }
    
    @IBOutlet var textTransactionLabel: UILabel!
    @IBOutlet var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let message = coinsMessage?.name else { return }
        
        textTransactionLabel.text = "Parabéns!\nVocê acabou de \(transactionMessage) \(amountMessage) \(tagCoinsMessage) - \(message), totalizando R$ \(totalTransaction)"
        
        homeButton.layer.cornerRadius = 20
        homeButton.isEnabled = true
    }
    
    // MARK: Actions
    @IBAction func homeNav(_ sender: UIButton) {
        if let nc = navigationController {
            nc.popToRootViewController(animated: true)
        }
    }
}

