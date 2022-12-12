//
//  Extension.swift
//  ChallengeBRQ
//
//  Created by Gustavo Hossein on 07/11/22.
//

import UIKit

//MARK: - Layout Screen View
extension UIView {
    func borderView() {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}

//MARK: - Variation Color
extension UILabel {
    func colorVariation(_ variacao: Double) {
        if variacao > 0 {
            self.textColor = UIColor(red: 0.494, green: 0.827, blue: 0.129, alpha: 1.0)
        } else if variacao == 0 {
            self.textColor = .white
        } else {
            self.textColor = UIColor(red: 0.815, green: 0.007, blue: 0.105, alpha: 1.0)
        }
    }
}

//MARK: - Layout screen TextField
extension UITextField {
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setPlaceholder() {
        let grayPlaceholderText = NSAttributedString(string: "Quantidade", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            
        self.attributedPlaceholder = grayPlaceholderText
    }
    
    func setBorderTextField() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

//MARK: - Exchange screen button
extension UIButton {
    func setBorderButton() {
        self.layer.cornerRadius = 20
    }
}
