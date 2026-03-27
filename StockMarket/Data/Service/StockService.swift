//
//  StockService.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

final class StockService: StockServiceProtocol {

    private let network: NetworkClientProtocol

    init(network: NetworkClientProtocol) {
        self.network = network
    }

    func fetchStocks() async throws -> StockListResponse {

        let endpoint = Endpoint(
            path: "market/v2/get-summary",
            queryItems: [
                URLQueryItem(name: "region", value: "US")
            ]
        )

        return try await network.request(endpoint: endpoint)
    }

    func fetchStockDetail(
        symbol: String
    ) async throws -> StockDetailResponse {

        print(symbol)
        let endpoint = Endpoint(
            path: "market/v2/get-quotes", //"stock/v2/get-summary",
            queryItems: [
                URLQueryItem(name: "region", value: "US"),
                URLQueryItem(name: "symbols", value: symbol)
            ]
        )

        return try await network.request(endpoint: endpoint)
    }
}
