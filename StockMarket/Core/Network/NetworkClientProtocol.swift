//
//  NetworkClientProtocol.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T
}
