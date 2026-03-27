//
//  StockListViewModel.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import Foundation

@MainActor
final class StockListViewModel: ObservableObject {
    
    @Published var stocks: [Stock] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getStocksUseCase: GetStocksUseCase
    
    private var timerTask: Task<Void, Never>?
    
    var filteredStocks: [Stock] {
        if searchText.isEmpty {
            return stocks
        }
        return stocks.filter {
            $0.name
                .lowercased()
                .contains(searchText.lowercased())
        }
    }
    
    init(getStocksUseCase: GetStocksUseCase) {
        self.getStocksUseCase = getStocksUseCase
    }
    
    func fetchStocks() {
        Task {
            isLoading = true
            errorMessage = nil
            do {
                let list =
                try await getStocksUseCase.execute()
                stocks = list
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
    
    func startAutoRefresh() {
        timerTask?.cancel()
        timerTask = Task {
            while !Task.isCancelled {
                fetchStocks()
                try? await Task.sleep(
                    nanoseconds: 8000000000
                )
            }
        }
    }
    
    func stopAutoRefresh() {
        timerTask?.cancel()
    }
    
}
