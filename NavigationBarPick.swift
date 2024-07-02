//
//  NavigationBarPick.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import SwiftUI

struct NavigationBarPick: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var place: Places
    
    var body: some View {
        
        HStack {
            
            
            Menu {
                
                Button(action: {
                    place = .restaurants
                }, label: {
                    Label("Restaurants", systemImage: "fork.knife")
                })
                
                Button(action: {
                    place = .hotels
                }, label: {
                    Label("Hotels", systemImage: "house")
                })
                
                Button(action: {
                    place = .attractions
                }, label: {
                    Label("Attractions", systemImage: "mountain.2")
                })
                
                Button(action: {
                    place = .geos
                }, label: {
                    Label("Geos", systemImage: "globe")
                })
                
                
                
            } label: {

                HStack {
                    Text(place.category)
                    Image(systemName: place.systemImage)
                    Image(systemName: "chevron.down")
                }
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .font(.system(size: 18, weight: .medium))
            }
            
            Spacer()
        }
        .padding(.leading, 15)
    }
}

#Preview {
    NavigationBarPick(place: .constant(.restaurants))
}
