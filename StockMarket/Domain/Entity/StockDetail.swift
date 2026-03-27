//
//  StockDetail.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

struct StockDetail: Equatable {

    let id: String
    let name: String
    let price: Double
    let changePercent: Double
    let marketCap: Double?
    let volume: Double?

}
