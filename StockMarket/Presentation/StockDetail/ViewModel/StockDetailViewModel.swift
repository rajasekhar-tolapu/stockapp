//
//  StockDetailViewModel.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import Foundation

@MainActor
final class StockDetailViewModel: ObservableObject {
    
    @Published var stock: StockDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let useCase: GetStockDetailUseCase
    
    init(useCase: GetStockDetailUseCase) {
        self.useCase = useCase
    }
    
    func fetch(symbol: String) {
        print("Fetch called with \(symbol)")
        Task {
            isLoading = true
            errorMessage = nil
            
            
            do {
                
                let detail =
                try await useCase.execute(
                    symbol: symbol
                )
                stock = detail
                
                
            } catch {
                errorMessage =
                error.localizedDescription
                
            }
            isLoading = false
            
        }
    }
}
