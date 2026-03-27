//
//  GetStocksUseCase.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

final class GetStocksUseCase {

    private let repository: StockRepositoryProtocol

    init(repository: StockRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Stock] {
        try await repository.fetchStocks()
    }
}
