//
//  StockServiceProtocol.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

protocol StockServiceProtocol {

    func fetchStocks() async throws -> StockListResponse

    func fetchStockDetail(
        symbol: String
    ) async throws -> StockDetailResponse

}
