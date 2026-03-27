//
//  APIError.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case network(Error)
}
