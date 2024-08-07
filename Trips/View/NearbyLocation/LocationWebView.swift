//
//  LocationWebView.swift
//  Trips
//
//  Created by Atakan Başaran on 4.07.2024.
//

import SwiftUI

struct LocationWebView: View {
    
    @Environment(\.dismiss) var dismiss
    let urlString: String?
    
    var body: some View {
        WebView(urlString: urlString)
        
            .gesture(
                
                DragGesture()
                    .onChanged({ value in
                        if value.translation.width > 40 {
                            dismiss()
                        }
                    })
                
            )
            .navigationBarBackButtonHidden()
        
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.green)
                    }

                }
            }
    }
}

//#Preview {
//    LocationWebView()
//}
