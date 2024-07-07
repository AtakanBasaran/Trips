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
//    @Published var isLoading = false
    
    @Published var locationsSearch: [LocationData] = []
    @Published var locationSearchDetails: [LocationDetailsModel] = []
    @Published var locationSearchPhotoModels: [LocationImageModel] = []
    
    
    func fetchData(coordinate: CLLocationCoordinate2D, place: Places) {
        
//        isLoading = true
        
        Task {
            
            do {
                let newData = try await NetworkManager.shared.downloadData(coordinate: coordinate, place: place)
                
                DispatchQueue.main.async {
                    self.locations = newData.data
                    
                    DispatchQueue.global().async {
                        self.fetchDetailData(isNearby: true)
                        self.fetchLocationPhoto(isNearby: true)
                    }
                }
                
            } catch {
                
                if let serverError = error as? APIError {
                    
                    switch serverError {
                        
                    case .dataError:
                        print("dataError in fetching location data")
                        
                    case .parseError:
                        print("parseError in fetching location data")
                        
                    case .serverError:
                        print("serverError in fetching location data")
                    }
                }
            }
            
        }
        
        
    }
    
  
}
//MARK: - Location Detail Network Call
extension LocationViewModel {
    
    func fetchDetailData(isNearby: Bool) {
        
        Task {
            
            if !locations.isEmpty {
                
                do {
                    
                    if isNearby {
                        
                        for data in locations {
                            
                            let newDetailsData = try await NetworkManager.shared.downloadDetailsData(locationId: data.locationID)
                            
                            DispatchQueue.main.async {
                                self.locationDetails.append(newDetailsData)
                            }
                        }
                        
                    } else {
                        
                        for data in locationsSearch {
                            
                            let newDetailsData = try await NetworkManager.shared.downloadDetailsData(locationId: data.locationID)
                            
                            DispatchQueue.main.async {
                                self.locationSearchDetails.append(newDetailsData)
                            }
                        }
                    }
                    
//                    isLoading = false
                    
                } catch {
                    
//                    isLoading = false
                    if let serverError = error as? APIError {
                        
                        switch serverError {
                            
                        case .serverError:
                            print("server error in fetching location detail data")
                            
                        case .parseError:
                            print("parse error in fetching location detail data")
                            
                        case .dataError:
                            print("data error in fetching location detail data")
                        }
                    }
                }
                
                
            }
        }
    }
    
}


//MARK: - Location Photos Network call
extension LocationViewModel {
    
    func fetchLocationPhoto(isNearby: Bool) {
        
        Task {
            
            if !locations.isEmpty {
                
                do {
                    
                    if isNearby {
                        
                        for data in locations {
                            let photoData = try await NetworkManager.shared.downloadPhotos(locationId: data.locationID)
                            
                            DispatchQueue.main.async {
                                self.locationPhotoModels.append(photoData)
                            }
                        }
                    } else {
                        
                        for data in locationsSearch {
                            let photoData = try await NetworkManager.shared.downloadPhotos(locationId: data.locationID)
                            
                            DispatchQueue.main.async {
                                self.locationSearchPhotoModels.append(photoData)
                            }
                        }
                    }
                    
//                    isLoading = false
                    
                    
                } catch {
                    
//                    isLoading = false
                    
                    if let serverError = error as? APIError {
                        
                        switch serverError {
                            
                        case .serverError:
                            print("server error in fetching location photo data")
                            
                        case .parseError:
                            print("parse error in fetching location photo data")
                            
                        case .dataError:
                            print("data error in fetching location photo data")
                        }
                    }
                }
                
            }
        }
    }
}


extension LocationViewModel {
    
    func fetchSearchData(location: String) {
        
//        isLoading = true
        
        Task {
            
            do {
                let data = try await NetworkManager.shared.downloadSearchData(location: location)
                
                DispatchQueue.main.async {
                    self.locationsSearch = data.data
                    
                    DispatchQueue.global().async {
                        self.fetchDetailData(isNearby: false)
                        self.fetchLocationPhoto(isNearby: false)
                    }
                }
                
            } catch {
                
                if let serviceError = error as? APIError {
                    
                    switch serviceError {
                        
                    case .serverError:
                        print("server error in fetching location photo data")
                        
                    case .parseError:
                        print("parse error in fetching location photo data")
                        
                    case .dataError:
                        print("data error in fetching location photo data")
                    }
                }
            }
        }
    }
    
}
