//
//  ProgressView.swift
//  Trips
//
//  Created by Atakan Başaran on 3.07.2024.
//

import SwiftUI

struct ProgressLoadingView: View {
    
    var body: some View {
        
        ZStack {
            
            Color(.systemBackground)
                .ignoresSafeArea()
            
            ProgressView()
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProgressView()
}
