//
//  ProgressView.swift
//  Trips
//
//  Created by Atakan Başaran on 3.07.2024.
//

import SwiftUI
import Lottie

struct ProgressLoadingView: View {
    
    var body: some View {
        
        ZStack {
            
            Color(.systemBackground)
                .ignoresSafeArea()
            
            LottieView(animation: .named("search"))
                .looping()
                .frame(width: 250, height: 250, alignment: .top)
                .clipped()
                .padding(.bottom, 50)
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProgressView()
}
