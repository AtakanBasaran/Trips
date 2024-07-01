//
//  LocationViewModel.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import SwiftUI


class LocationViewModel: ObservableObject {
    
    @Published var locations: [LocationData] = []
    
    func fetchData() {
        
        Task {
            
            do {
                let newData = try await NetworkManager.shared.downloadData()
                locations = newData.data
                
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
