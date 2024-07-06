//
//  LocationWebView.swift
//  Trips
//
//  Created by Atakan Başaran on 4.07.2024.
//

import SwiftUI

struct LocationWebView: View {
    
    let urlString: String?
    
    var body: some View {
        WebView(urlString: urlString)
    }
}

//#Preview {
//    LocationWebView()
//}
