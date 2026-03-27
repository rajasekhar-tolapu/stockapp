//
//  StockListView.swift
//  StockMarket
//
//  Created by Raaja on 27/03/26.
//

import SwiftUI

struct StockListView: View {
    
    @StateObject
    private var viewModel: StockListViewModel
    let container = AppContainer()
    
    init(container: AppContainer) {
        
        _viewModel = StateObject(
            wrappedValue: StockListViewModel(
                getStocksUseCase: container.makeGetStocksUseCase()
            )
        )
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            content
            
                .navigationTitle("Stocks")
            
                .searchable(
                    text: $viewModel.searchText
                )
            
                .task {
                    viewModel.fetchStocks()
                    viewModel.startAutoRefresh()
                }
            
                .onDisappear {
                    viewModel.stopAutoRefresh()
                }
        }
    }
}

private extension StockListView {
    @ViewBuilder
    var content: some View {
        
        if viewModel.isLoading {
            
            ProgressView().scaleEffect(1.5)
            
        } else if let error =
                    viewModel.errorMessage {
            
            VStack(spacing: 12) {
                Text("Something went wrong")
                    .font(.headline)
                
                Text(error)
                    .font(.caption)
                
                Button("Retry") {
                    viewModel.fetchStocks()
                }
            }
            
        } else {
            
            listView
        }
    }
}

private extension StockListView {
    
    var listView: some View {
        
        List(viewModel.filteredStocks) { stock in
            
            NavigationLink {
                makeDetailView(symbol: stock.id)
            } label: {
                row(stock).id(stock.id)
            }
        }
    }
    
    func makeDetailView(
        symbol: String
    ) -> some View {
        
        return StockDetailView(
            symbol: symbol,
            container: container
        )
    }
}



private extension StockListView {
    
    func row(_ stock: Stock) -> some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(stock.name)
                    .font(.headline)
                
                Text(stock.id)
                    .font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
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
            }
        }
    }
}

struct StockListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let container = AppContainer()
        StockListView(container: container)
    }
}
