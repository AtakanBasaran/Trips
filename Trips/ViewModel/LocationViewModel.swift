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
    @Published var locationDetails: [LocationDetailsModel] = []
    @Published var locationPhotoModels: [LocationImageModel] = []
    @Published var isLoading = false
    
    
    func fetchData(coordinate: CLLocationCoordinate2D, place: Places) {
        isLoading = true
        
        Task {
            
            do {
                let newData = try await NetworkManager.shared.downloadData(coordinate: coordinate, place: place)
                
                DispatchQueue.main.async {
                    self.locations = newData.data
                    
                    DispatchQueue.global().async {
                        self.fetchDetailData()
                        self.fetchLocationPhoto()
                    }
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
                        
                    }
                }
            }
            
        }
        
        
    }
    
    
    func fetchDetailData() {
        
        Task {
            
            if !locations.isEmpty {
                
                do {
                    for data in locations {
                        
                        let newDetailsData = try await NetworkManager.shared.downloadDetailsData(locationId: data.locationID)
                        
                        DispatchQueue.main.async {
                            self.locationDetails.append(newDetailsData)
                        }
                    }
                    isLoading = false
                } catch {
                    
                    if let serverError = error as? APIError {
                        
                        switch serverError {
                            
                        case .serverError:
                            print("server error")
                            
                        case .parseError:
                            print("parse error")
                            
                        case .dataError:
                            print("data error")
                        }
                    }
                }
                
                
            }
        }
    }
    
    func fetchLocationPhoto() {
        
        Task {
            
            if !locations.isEmpty {
                
                do {
                    
                    for data in locations {
                        let photoData = try await NetworkManager.shared.downloadPhotos(locationId: data.locationID)
                        
                        DispatchQueue.main.async {
                            self.locationPhotoModels.append(photoData)
                        }
                    }
                    
                    isLoading = false
                    print(locationPhotoModels)
                    
                } catch {
                    
                    if let serverError = error as? APIError {
                        
                        switch serverError {
                            
                        case .serverError:
                            print("server error")
                            
                        case .parseError:
                            print("parse error")
                            
                        case .dataError:
                            print("data error")
                        }
                    }
                }
                
            }
        }
    }
}
