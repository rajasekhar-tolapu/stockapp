//
//  File.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import Foundation

extension Double {
    func to1DecimalCurrency() -> String {
        String(format: "%.2f", self)
    }
    
    func to2DecimalCurrency() -> String {
        String(format: "%.2f%%", self)
    }
    
    
}
