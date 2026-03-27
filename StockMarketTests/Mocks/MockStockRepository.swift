//
//  MockStockRepository.swift
//  StockMarketTests
//
//  Created by Raaja on 27/03/26.
//

@testable import StockMarket
import Foundation

final class MockStockRepository: StockRepositoryProtocol {

    var stocks: [Stock] = []
    var shouldThrow = false

    func fetchStocks() async throws -> [Stock] {

        if shouldThrow {
            throw URLError(.badServerResponse)
        }

        return stocks
    }

    func fetchStockDetail(
        symbol: String
    ) async throws -> StockDetail {

        StockDetail(
            id: symbol,
            name: "Test",
            price: 100,
            changePercent: 1,
            marketCap: nil,
            volume: nil
        )
    }
}
