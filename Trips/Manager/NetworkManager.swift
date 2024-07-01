//
//  NetworkManager.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import Foundation

enum APIError: Error {
    case serverError
    case urlError
    case parseError
    case dataError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func downloadData() async throws -> LocationModel {
        
        let url = URL(string: "https://api.content.tripadvisor.com/api/v1/location/nearby_search")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "latLong", value: "40.21742%2C28.96812"),
            URLQueryItem(name: "key", value: "C05C617B619D401E9896F326F6226771"),
            URLQueryItem(name: "category", value: "hotels"),
            URLQueryItem(name: "radius", value: "10"),
            URLQueryItem(name: "radiusUnit", value: "km"),
            URLQueryItem(name: "language", value: "en"),
        ]
        
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.serverError
        }
        
        
        if data.isEmpty {
            throw APIError.dataError
        }
        
        do {
            let decodedData = try JSONDecoder().decode(LocationModel.self, from: data)
            return decodedData
            
        } catch {
            throw APIError.parseError
        }
        
        
        
        
    }
}


