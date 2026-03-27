//
//  StockRepositoryProtocol.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

protocol StockRepositoryProtocol {

    func fetchStocks() async throws -> [Stock]

    func fetchStockDetail(
        symbol: String
    ) async throws -> StockDetail

}
