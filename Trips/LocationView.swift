//
//  ContentView.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = LocationViewModel()
    
    var body: some View {
        
        List {
            ForEach(vm.locations, id: \.locationID) { location in
                
                Text(location.name)
            }
                
            
        }
        
        .task {
            vm.fetchData()
        }
    }
    
}

#Preview {
    ContentView()
}
