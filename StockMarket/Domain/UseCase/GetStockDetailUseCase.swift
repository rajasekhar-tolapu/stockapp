//
//  GetStockDetailUseCase.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

final class GetStockDetailUseCase {

    private let repository: StockRepositoryProtocol

    init(repository: StockRepositoryProtocol) {
        self.repository = repository
    }

    func execute(symbol: String) async throws -> StockDetail {
        try await repository.fetchStockDetail(symbol: symbol)
    }
}
