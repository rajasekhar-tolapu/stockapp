//
//  GetStocksUseCaseTests.swift
//  StockMarketTests
//
//  Created by Raaja on 27/03/26.
//

@testable import StockMarket
import XCTest

final class GetStocksUseCaseTests: XCTestCase {

    func testExecuteReturnsStocks() async throws {

        // Arrange
        let repository = MockStockRepository()

        repository.stocks = [
            Stock(
                id: "AAPL",
                name: "Apple",
                price: 100,
                changePercent: 1
            ),
            Stock(
                id: "MSFT",
                name: "Microsoft",
                price: 200,
                changePercent: -0.5
            )
        ]

        let useCase = GetStocksUseCase(
            repository: repository
        )

        // Act
        let result = try await useCase.execute()

        // Assert
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.id, "AAPL")
    }

    func testExecuteThrowsError() async {

        // Arrange
        let repository = MockStockRepository()
        repository.shouldThrow = true

        let useCase = GetStocksUseCase(
            repository: repository
        )

        // Act & Assert
        do {

            _ = try await useCase.execute()
            XCTFail("Expected error to be thrown")

        } catch {

            XCTAssertTrue(true)
        }
    }
}
