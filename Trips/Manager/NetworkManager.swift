//
//  NetworkManager.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import Foundation
import CoreLocation

enum APIError: Error {
    case serverError
    case parseError
    case dataError
}

enum Places: String {
    
    case hotels = "hotels"
    case attractions = "attractions"
    case restaurants = "restaurants"
    case geos = "geos"
    
    var category: String {
        
        switch self {
            
        case .attractions:
            return "Attractions"
            
        case .geos:
            return "Geos"
            
        case .hotels:
            return "Hotels"
            
        case .restaurants:
            return "Restaurants"
        }
    }
    
    var systemImage: String {
        
        switch self {
            
        case .hotels:
            return "house"
            
        case .attractions:
            return "mountain.2"
            
        case .restaurants:
            return "fork.knife"
            
        case .geos:
            return "globe"
        }
    }
    
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Download Data
    
    func downloadData(coordinate: CLLocationCoordinate2D, place: Places) async throws -> LocationModel {
        
        let url = URL(string: "https://api.content.tripadvisor.com/api/v1/location/nearby_search")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "latLong", value: "\(coordinate.latitude)%2C\(coordinate.longitude)"),
            URLQueryItem(name: "key", value: "C05C617B619D401E9896F326F6226771"),
            URLQueryItem(name: "category", value: place.rawValue),
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
    
    //MARK: - Download Details
    
    func downloadDetailsData(locationId: String) async throws -> LocationDetailsModel {
        
        let url = URL(string: "https://api.content.tripadvisor.com/api/v1/location/\(locationId)/details")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: "C05C617B619D401E9896F326F6226771"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "currency", value: "USD"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.serverError
        }
        
        if data.isEmpty {
            throw APIError.dataError
        }
        
        
        do {
            let decodedData = try JSONDecoder().decode(LocationDetailsModel.self, from: data)
            return decodedData
            
        } catch {
            throw APIError.parseError
        }
    }
    
    //MARK: - Download Photos
    
    func downloadPhotos(locationId: String) async throws -> LocationImageModel {
        
        let url = URL(string: "https://api.content.tripadvisor.com/api/v1/location/\(locationId)/photos")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: "C05C617B619D401E9896F326F6226771"),
            URLQueryItem(name: "language", value: "en"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.serverError
        }
        
        if data.isEmpty {
            throw APIError.dataError
        }
        
        do {
            let decodeData = try JSONDecoder().decode(LocationImageModel.self, from: data)
            return decodeData
            
        } catch {
            throw APIError.parseError
        }
        
    }
}

//MARK: - Download Search Photos

extension NetworkManager {
    
    func downloadSearchData(location: String) async throws -> LocationModel {
        
        let url = URL(string: "https://api.content.tripadvisor.com/api/v1/location/search")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "key", value: "C05C617B619D401E9896F326F6226771"),
            URLQueryItem(name: "searchQuery", value: location),
            URLQueryItem(name: "language", value: "en"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
        let (data, response) = try await URLSession.shared.data(for: request)
//        print(String(decoding: data, as: UTF8.self))
        
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


