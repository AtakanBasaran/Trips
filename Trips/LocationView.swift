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
                
                List {
                    ForEach(vm.locations, id: \.locationID) { location in
                        
                        Text(location.name)
                    }
                        
                }
                
               
            }
            .navigationTitle("Nearby Search")
            
        }
        
        .onChange(of: place) { value in
            
            if let coordinate = locationManager.lastKnownLocation {
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
