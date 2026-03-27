//
//  StockDetailView.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import SwiftUI

struct StockDetailView: View {
    
    @StateObject
    private var viewModel:
    StockDetailViewModel
    
    let symbol: String
    
    init(symbol: String, container: AppContainer) {
        
        self.symbol = symbol
        
        _viewModel = StateObject(
            wrappedValue: StockDetailViewModel(
                useCase: container.makeGetStockDetailUseCase()
            )
        )
    }
    
    var body: some View {
        content
            .navigationTitle(symbol)
            .task(priority: .userInitiated) {
                if viewModel.stock == nil {
                    viewModel.fetch(symbol: symbol)
                }
            }
    }
}

private extension StockDetailView {
    
    @ViewBuilder
    var content: some View {
        
        if viewModel.isLoading {
            
            ProgressView()
            
        } else if let error =
                    viewModel.errorMessage {
            
            Text(error)
            
        } else if let stock =
                    viewModel.stock {
            
            detail(stock)
            
        } else {
            
            Color.clear
                .frame(width: 0, height: 0)
                .onAppear {
                    viewModel.fetch(symbol: symbol)
                }
        }
    }
}

private extension StockDetailView {
    
    func detail(
        _ stock: StockDetail
    ) -> some View {
        
        VStack(spacing: 16) {
            
            Text(stock.name)
                .font(.title)
            
            Text(
                stock.price.to1DecimalCurrency()
            )
            
            Text(
                
                stock.changePercent.to2DecimalCurrency()
                
            )
            .foregroundColor(
                stock.changePercent >= 0
                ? .green : .red
            )
            
            if let cap = stock.marketCap {
                
                Text("MarketCap: \(cap)")
            }
            
            if let volume = stock.volume {
                
                Text("Volume: \(volume)")
            }
            
            Spacer()
        }
        .padding()
    }
}

struct StockDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let container = AppContainer()
        
        StockDetailView(
            symbol: "AAPL",
            container: container
        )
    }
}
