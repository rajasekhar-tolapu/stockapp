//
//  StockRepository.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import Foundation

final class StockRepository: StockRepositoryProtocol {

    private let service: StockServiceProtocol

    init(service: StockServiceProtocol) {
        self.service = service
    }

    func fetchStocks() async throws -> [Stock] {

        let response = try await service.fetchStocks()

        let list = response
            .marketSummaryAndSparkResponse
            .result

        return list.map {

            Stock(
                id: $0.symbol,
                name: $0.shortName ?? "",
                price: $0.regularMarketPrice?.raw ?? 0,
                changePercent:
                    $0.regularMarketChangePercent?.raw ?? 0
            )
        }
    }   

    func fetchStockDetail(
        symbol: String
    ) async throws -> StockDetail {

        let response =
            try await service.fetchStockDetail(symbol: symbol)

        let item = response.quoteResponse.result.first

        return StockDetail(
            id: item?.symbol ?? "",
            name: item?.shortName ?? "",
            price: item?.regularMarketPrice ?? 0,
            changePercent: item?.regularMarketChangePercent ?? 0,
            marketCap: item?.marketCap,
            volume: item?.regularMarketVolume
        )
    }
}
