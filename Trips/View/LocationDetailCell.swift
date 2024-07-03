//
//  LocationDetailCell.swift
//  Trips
//
//  Created by Atakan Başaran on 2.07.2024.
//

import SwiftUI

struct LocationDetailCell: View {
    
    let locationDetail: LocationDetailsModel
    let locationImageModel: LocationImageModel
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing: 7) {
                Text(locationDetail.name)
                    .font(.system(size: 20, weight: .bold))
                
                if let rating = locationDetail.rating {
                    Text("Rating: \(rating) / 5")
                        .font(.system(size: 14, weight: .medium))
                }
                
                if let priceLevel = locationDetail.priceLevel {
                    Text("Price Level: \(priceLevel)")
                        .font(.system(size: 14, weight: .medium))
                }
                
            }
            .padding(.leading, 15)
            
            Spacer()
            
            AsyncImage(url: URL(string: locationImageModel.data?.first?.images.original.url ?? "")) { image in
                
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
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.trailing, 15)
            }
            
        }
        .frame(height: 120)
    }
}

#Preview {
    LocationDetailCell(locationDetail: MockData.mockLocationDetail, locationImageModel: MockData.mockImageModel)
}
