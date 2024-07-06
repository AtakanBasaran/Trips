//
//  LocationSearchView.swift
//  Trips
//
//  Created by Atakan Başaran on 4.07.2024.
//

import SwiftUI

struct LocationSearchView: View {
    
    @EnvironmentObject var vm: LocationViewModel
    @State private var searchLocationText = ""
    
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                ScrollView {
                    
                    ForEach(Array(zip(vm.locationSearchDetails, vm.locationSearchPhotoModels)), id: \.0.locationID) { (data, photo) in
                        
                        NavigationLink {
                            LocationWebView(urlString: data.webURL)
                        } label: {
                            LocationDetailCell(locationDetail: data, locationImageModel: photo)
                        }
           
                    }
                }
                .searchable(text: $searchLocationText, placement: .toolbar, prompt: "Search Location")
                .onSubmit(of: .search) {
                    vm.fetchSearchData(location: searchLocationText)
                }
                
                if vm.isLoading {
                    ProgressLoadingView()
                }
            }
        }
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = LocationViewModel()
        // Add some mock data to the view model if needed
        
        return LocationSearchView()
            .environmentObject(viewModel)
    }
}
