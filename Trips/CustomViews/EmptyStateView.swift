//
//  EmptyStateView.swift
//  Trips
//
//  Created by Atakan Başaran on 7.08.2024.
//

import SwiftUI
import Lottie

struct EmptyStateView: View {
    
    var body: some View {
        
        ZStack {
            
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                LottieView(animation: .named("empty"))
                    .looping()
                    .frame(width: 250, height: 250, alignment: .top)
                    .clipped()
                    
                
                Text("Where would you like to go 🧳")
                    .font(.headline)
            }
            .padding(.bottom, 100)
            
        }
    }
}

#Preview {
    EmptyStateView()
}
