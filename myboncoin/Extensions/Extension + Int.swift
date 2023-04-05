//
//  Extension + Int.swift
//  myboncoin
//
//  Created by James Tapping on 04/04/2023.
//

import Foundation

extension Int {
    var euroCurrencyString: String {
        let euroFormatter = NumberFormatter()
        euroFormatter.numberStyle = .currency
        euroFormatter.currencySymbol = "€"
        return euroFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
