//
//  GetStockDetailUseCaseTests.swift
//  StockMarketTests
//
//  Created by Raaja on 27/03/26.
//

@testable import StockMarket
import XCTest

final class GetStockDetailUseCaseTests: XCTestCase {

    func testExecuteReturnsStockDetail() async throws {

        let repository = MockStockRepository()

        let useCase = GetStockDetailUseCase(
            repository: repository
        )

        let result =
            try await useCase.execute(symbol: "AAPL")

        XCTAssertEqual(result.id, "AAPL")
        XCTAssertEqual(result.name, "Test")
    }

    func testExecuteThrowsError() async {

        let repository = MockStockRepository()
        repository.shouldThrow = true

        let useCase = GetStockDetailUseCase(
            repository: repository
        )

        do {

            _ = try await useCase.execute(symbol: "AAPL")
            XCTFail("Expected error")

        } catch {

            XCTAssertTrue(true)
        }
    }
}
