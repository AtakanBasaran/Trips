//
//  ContentView.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = LocationViewModel()
    @StateObject var locationManager = LocationManager()
    @State private var place: Places = .restaurants
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                NavigationBarPick(place: $place)
                
                ScrollView {
                    
                    ForEach(Array(zip(vm.locationDetails, vm.locationPhotoModels)), id: \.0.locationID) { (locationDetail, locationImage) in
                        
                        LocationDetailCell(locationDetail: locationDetail, locationImageModel: locationImage)
                    }
                        
                }
                
               
            }
            .navigationTitle("Nearby Search")
            
        }
        
        .onChange(of: place) { value in
            
            if let coordinate = locationManager.lastKnownLocation {
                vm.locationDetails.removeAll()
                vm.locationPhotoModels.removeAll()
                vm.fetchData(coordinate: coordinate, place: value)
            }
        }
        

        .task {
            locationManager.checkLocationAuthorization()
            if let coordinate = locationManager.lastKnownLocation {
                vm.fetchData(coordinate: coordinate, place: place)
            }
        }
    
    }
    
}

#Preview {
    ContentView()
}
