//
//  LocationSearchView.swift
//  Trips
//
//  Created by Atakan Başaran on 4.07.2024.
//

import SwiftUI
import Lottie

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
                .padding(.top, 5)
                .padding(.bottom, 5)
                .searchable(text: $searchLocationText, placement: .toolbar, prompt: "Search Location")
                .onSubmit(of: .search) {
                    
                    DispatchQueue.main.async {
                        vm.locationSearchDetails.removeAll()
                        vm.locationSearchPhotoModels.removeAll()
                    }
                    vm.fetchSearchData(location: searchLocationText)
                }
                
                if vm.locationSearchDetails.isEmpty {
                    EmptyStateView()
                }
                
                
                if vm.isLoadingSearch {
                    ProgressLoadingView()
                }
            }
            .navigationTitle("Locations")
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



