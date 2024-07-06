//
//  WebViewLocation.swift
//  Trips
//
//  Created by Atakan Başaran on 4.07.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let urlString {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}


//#Preview {
//    WebViewLocation(urlString: "")
//}
