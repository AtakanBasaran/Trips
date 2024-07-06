//
//  TabView.swift
//  Trips
//
//  Created by Atakan Başaran on 4.07.2024.
//

import SwiftUI

struct TabViews: View {
    
    @StateObject var vm = LocationViewModel()
    
    var body: some View {
        
        TabView {
            
            LocationView()
                .tabItem {
                    Label("Nearby", systemImage: "location")
                }
            
            LocationSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
        }
        .tint(.green)
        .environmentObject(vm)
    }
}

#Preview {
    TabViews()
}
