//
//  StockDetailViewModelTests.swift
//  StockMarketTests
//
//  Created by Raaja on 27/03/26.
//

@testable import StockMarket
import XCTest

@MainActor
final class StockDetailViewModelTests: XCTestCase {

    var repository: MockStockRepository!
    var useCase: GetStockDetailUseCase!
    var viewModel: StockDetailViewModel!

    override func setUp() {

        repository = MockStockRepository()

        useCase = GetStockDetailUseCase(
            repository: repository
        )

        viewModel = StockDetailViewModel(
            useCase: useCase
        )
    }

    // ✅ Success case
    func testFetchDetailSuccess() async {

        viewModel.fetch(symbol: "AAPL")

        try? await Task.sleep(
            nanoseconds: 300_000_000
        )

        XCTAssertEqual(
            viewModel.stock?.id,
            "AAPL"
        )

        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    // ❌ Error case
    func testFetchDetailFailure() async {

        repository.shouldThrow = true

        viewModel.fetch(symbol: "AAPL")

        try? await Task.sleep(
            nanoseconds: 300_000_000
        )

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.stock)
        XCTAssertFalse(viewModel.isLoading)
    }

    // ⏳ Loading state test (optional but strong)
    func testLoadingState() async {

        viewModel.fetch(symbol: "AAPL")

        XCTAssertTrue(viewModel.isLoading)
    }
}
