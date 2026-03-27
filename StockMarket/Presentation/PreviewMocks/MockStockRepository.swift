//
//  MockStockRepository.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import Foundation

final class MockStockRepository: StockRepositoryProtocol {

    func fetchStocks() async throws -> [Stock] {

        [
            Stock(
                id: "AAPL",
                name: "Apple",
                price: 190,
                changePercent: 1.5
            ),
            Stock(
                id: "MSFT",
                name: "Microsoft",
                price: 330,
                changePercent: -0.8
            )
        ]
    }

    func fetchStockDetail(
        symbol: String
    ) async throws -> StockDetail {

        StockDetail(
            id: symbol,
            name: "Apple",
            price: 190,
            changePercent: 1.2,
            marketCap: 1000,
            volume: 200
        )
    }
}
