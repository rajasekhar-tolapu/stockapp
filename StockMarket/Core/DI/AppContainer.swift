//
//  AppContainer.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import Foundation

final class AppContainer {

    // MARK: - Network
    private lazy var network: NetworkClientProtocol = {
        URLSessionNetworkClient()
    }()

    // MARK: - Service
    private lazy var stockService: StockServiceProtocol = {
        StockService(network: network)
    }()

    // MARK: - Repository
    private lazy var stockRepository:
        StockRepositoryProtocol = {
        StockRepository(service: stockService)
    }()

    // MARK: - UseCases
    func makeGetStocksUseCase() -> GetStocksUseCase {
        GetStocksUseCase(
            repository: stockRepository
        )
    }

    func makeGetStockDetailUseCase() -> GetStockDetailUseCase {
        GetStockDetailUseCase(
            repository: stockRepository
        )
    }

    // MARK: - ViewModels
    @MainActor
    func makeStockListViewModel() -> StockListViewModel {
        StockListViewModel(
            getStocksUseCase:
                makeGetStocksUseCase()
        )
    }

    @MainActor
    func makeStockDetailViewModel() -> StockDetailViewModel {
        StockDetailViewModel(
            useCase:
                makeGetStockDetailUseCase()
        )
    }
}
