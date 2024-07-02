//
//  LocationViewModel.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import SwiftUI
import CoreLocation


class LocationViewModel: ObservableObject {
    
    @Published var locations: [LocationData] = []
    
    
    func fetchData(coordinate: CLLocationCoordinate2D, place: Places) {
        
        Task {
            
            do {
                let newData = try await NetworkManager.shared.downloadData(coordinate: coordinate, place: place)
                
                DispatchQueue.main.async {
                    self.locations = newData.data
                }
                
            } catch {
                
                if let serverError = error as? APIError {
                    
                    switch serverError {
            
                    case .dataError:
                        print("dataError")
                        
                    case .parseError:
                        print("parseError")
                        
                    case .serverError:
                        print("serverError")
                        
                    case .urlError:
                        print("urlError")
                    }
                }
            }
        }
        
    }
}
