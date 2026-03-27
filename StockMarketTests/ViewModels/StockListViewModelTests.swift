//
//  StockListViewModelTests.swift
//  StockMarketTests
//
//  Created by Raaja on 27/03/26.
//

@testable import StockMarket
import XCTest

@MainActor
final class StockListViewModelTests: XCTestCase {
    
    var repository: MockStockRepository!
    var useCase: GetStocksUseCase!
    var viewModel: StockListViewModel!
    
    override func setUp() {
        
        repository = MockStockRepository()
        
        useCase =
        GetStocksUseCase(
            repository: repository
        )
        
        viewModel =
        StockListViewModel(
            getStocksUseCase: useCase
        )
    }
    
    func testFetchStocksSuccess()
    async {
        
        repository.stocks = [
            Stock(
                id: "AAPL",
                name: "Apple",
                price: 100,
                changePercent: 1
            )
        ]
        
        viewModel.fetchStocks()
        
        try? await Task.sleep(
            nanoseconds: 300_000_000
        )
        
        XCTAssertEqual(
            viewModel.stocks.count,
            1
        )
    }
    
    func testFetchStocksError()
    async {
        
        repository.shouldThrow = true
        
        viewModel.fetchStocks()
        
        try? await Task.sleep(
            nanoseconds: 300_000_000
        )
        
        XCTAssertNotNil(
            viewModel.errorMessage
        )
    }
    
    func testSearchFiltering() async {
        
        repository.stocks = [
            Stock(
                id: "AAPL",
                name: "Apple",
                price: 1,
                changePercent: 1
            ),
            Stock(
                id: "MSFT",
                name: "Microsoft",
                price: 1,
                changePercent: 1
            )
        ]
        
        viewModel.fetchStocks()
        
        try? await Task.sleep(
            nanoseconds: 300_000_000
        )
        
        viewModel.searchText = "App"
        
        XCTAssertEqual(
            viewModel.filteredStocks.count,
            1
        )
    }
}
