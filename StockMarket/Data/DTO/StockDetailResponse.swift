//
//  StockDetailResponse.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

struct StockDetailResponse: Decodable {
    let quoteResponse: QuoteResponse
}

struct QuoteResponse: Decodable {
    let result: [QuoteDTO]
}

struct QuoteDTO: Decodable {

    let symbol: String
    let shortName: String?

    let regularMarketPrice: Double?
    let regularMarketChangePercent: Double?

    let regularMarketVolume: Double?
    let marketCap: Double?

}
