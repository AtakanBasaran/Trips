//
//  RatingCircleView.swift
//  Trips
//
//  Created by Atakan Başaran on 3.07.2024.
//

import SwiftUI

struct RatingCircleView: View {
    
    var rating: Double
    
    var body: some View {
        
        HStack(spacing: 3) {
            
            ForEach(0..<5) { index in
                CircleView(fillAmount: isCircleFilled(at: index))
            }
        }
    }
    
    private func isCircleFilled(at index: Int) -> Double {
        
        if rating >= Double(index + 1) {
            return 1.0
            
        } else if rating > Double(index) {
            return rating - Double(index)
            
        } else {
            return 0.0
        }
        
    }
}

struct CircleView: View {
    
    var fillAmount: Double
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .strokeBorder(Color.gray, lineWidth: 1)
                .background(Circle().fill(Color.gray.opacity(0.3)))
            
            Circle()
                .trim(from: 0, to: CGFloat(fillAmount))
                .fill(Color.green)
                .rotationEffect(.degrees(90))
        }
        .frame(width: 10, height: 10)
            
            
    }
}

#Preview {
//    RatingCircleView(rating: 3.5)
    CircleView(fillAmount: 0.5)
}
