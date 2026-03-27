//
//  URLSessionNetworkClient.swift
//  StockMarket
//
//  Created by Raaja on 26/03/26.
//

import Foundation

final class URLSessionNetworkClient: NetworkClientProtocol {
    
    private let baseURL = "https://yh-finance.p.rapidapi.com/"
    
    private let apiKey = "b8c5797409mshd4e5203dfb658b0p10f2a6jsn4a29add920f8"
    private let host = "yh-finance.p.rapidapi.com"
    
    func request<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T {
        
        guard var components = URLComponents(
            string: baseURL + endpoint.path
        ) else {
            throw APIError.invalidURL
        }
        
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.setValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue(host, forHTTPHeaderField: "X-RapidAPI-Host")
        
        print(url.absoluteString)
        print(request.allHTTPHeaderFields)
        
        do {
            
            let (data, response) =
            try await URLSession.shared.data(for: request)
            
            guard let httpResponse =
                    response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else {
                throw APIError.invalidResponse
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingError
            }
            
        } catch let error {
            throw APIError.network(error)
        }
    }
}
