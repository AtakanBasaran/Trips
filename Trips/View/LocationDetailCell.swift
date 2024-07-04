//
//  LocationDetailCell.swift
//  Trips
//
//  Created by Atakan Başaran on 2.07.2024.
//

import SwiftUI

struct LocationDetailCell: View {
    
    let locationDetail: LocationDetailsModel
    let locationImageModel: LocationImageModel?
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing: 7) {
                Text(locationDetail.name)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.leading)
                
                HStack {
                    if let rating = locationDetail.rating, let doubleRating = Double(rating)  {
                        RatingCircleView(rating: doubleRating)
                    }
                    
                    if let numReviews = locationDetail.numReviews {
                        if let revInt = Int(numReviews) {
                            if revInt > 0 {
                                Text("(\(numReviews))")
                            }
                        }
                        
                    }
                    
                    
                }
                
                if let priceLevel = locationDetail.priceLevel {
                    Text("Price Level: \(priceLevel)")
                        .font(.system(size: 14, weight: .medium))
                }
                
            }
            .padding(.leading, 15)
            
            Spacer()
            
            AsyncImage(url: URL(string: locationImageModel?.data?.first?.images.original?.url ?? "https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg?t=st=1720033468~exp=1720037068~hmac=c6bbd06968b92c86e282a6bfa79ee7c69222a00b0de2ff37051ca38a35428e39&w=1480")) { image in
                
                image
                    .resizable()
                    .frame(width: 110, height: 110)
                    .clipped()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.trailing, 15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(LinearGradient(colors: [Color(.darkGray)], startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 1))
                            .padding(.trailing, 15)
                    }
                
            } placeholder: {
//                Image("placeholder")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 110, height: 110)
//                    .clipped()
//                    .clipShape(.rect(cornerRadius: 15))
//                    .padding(.trailing, 15)
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.darkGray))
                        .frame(width: 110, height: 110)
                    
                    ProgressView()
                }
                .padding(.trailing, 15)
            }
            
        }
        .frame(height: 120)
    }
}

#Preview {
    LocationDetailCell(locationDetail: MockData.mockLocationDetail, locationImageModel: MockData.mockImageModel)
}
