//
//  TripsApp.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import SwiftUI

@main
struct TripsApp: App {
    
    @StateObject var vm = LocationViewModel()
    @StateObject var locationManager = LocationManager()
    
    
    var body: some Scene {
        
        WindowGroup {
            TabViews()
                .task {
                    locationManager.checkLocationAuthorization()
                }
                .environmentObject(vm)
        }
    }
}
