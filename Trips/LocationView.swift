//
//  ContentView.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import SwiftUI


struct LocationView: View {
    
    @EnvironmentObject var vm: LocationViewModel
    @StateObject var locationManager = LocationManager()
    @State private var place: Places = .restaurants
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                VStack {
                    
                    NavigationBarPick(place: $place)
                        .padding(.top, 10)
                    
                    ScrollView {
                        
                        ForEach(Array(zip(vm.locationDetails, vm.locationPhotoModels)), id: \.0.locationID) { (locationDetail, locationImage) in
                            
                            NavigationLink {
                                LocationWebView(urlString: locationDetail.webURL)
                            } label: {
                                LocationDetailCell(locationDetail: locationDetail, locationImageModel: locationImage)
                            }
                        }
                    }
                    .padding(.bottom, 5)
                
      
                }
     
                if vm.isLoadingNearby {
                    ProgressLoadingView()
                }
            }
            
            
            
        }
        
        .onChange(of: place) { value in
            
            locationManager.checkLocationAuthorization()
            
            if let coordinate = locationManager.lastKnownLocation {
                
                DispatchQueue.main.async {
                    vm.locationDetails.removeAll()
                    vm.locationPhotoModels.removeAll()
                }
                vm.fetchData(coordinate: coordinate, place: value)
            }
        }
        
        
        .task {
            
            if vm.locations.isEmpty {
                locationManager.checkLocationAuthorization()
                
                if let coordinate = locationManager.lastKnownLocation {
                    vm.fetchData(coordinate: coordinate, place: place)
                }
            }
        }
        
        .refreshable {
            
            locationManager.checkLocationAuthorization()
            
            if let coordinate = locationManager.lastKnownLocation {
                
                DispatchQueue.main.async {
                    vm.locationDetails.removeAll()
                    vm.locationPhotoModels.removeAll()
                }
                vm.fetchData(coordinate: coordinate, place: place)
            }
        }
        
    }
    
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = LocationViewModel()
        
        return LocationView()
            .environmentObject(viewModel)
    }
}
