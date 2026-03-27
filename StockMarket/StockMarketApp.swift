//
//  StockMarketApp.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import SwiftUI

@main
struct StockMarketApp: App {
    
    let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            StockListView(container: container)
        }
    }
}
