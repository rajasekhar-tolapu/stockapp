//
//  StockListResponse.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

struct StockListResponse: Decodable {
    let marketSummaryAndSparkResponse: MarketSummaryResponse
}

struct MarketSummaryResponse: Decodable {
    let result: [StockDTO]
}

struct StockDTO: Decodable {
    let symbol: String
    let shortName: String?
    let regularMarketPrice: PriceDTO?
    let regularMarketChangePercent: PriceDTO?
}

struct PriceDTO: Decodable {
    let raw: Double?
}
