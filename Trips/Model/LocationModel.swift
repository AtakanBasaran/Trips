//
//  LocationModel.swift
//  Trips
//
//  Created by Atakan Başaran on 1.07.2024.
//

import Foundation

struct LocationModel: Codable {
    
    let data: [LocationData]
}

struct LocationData: Codable {
    
    let locationID: String
    let name: String
    let distance: String
    let bearing: String
    let addressObj: AddressObj
    
    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name
        case distance
        case bearing
        case addressObj = "address_obj"
    }
}


struct AddressObj: Codable {
    let street1: String?
    let street2: String?
    let city: String?
    let state: String?
    let country: String?
    let postalcode, addressString: String?

    enum CodingKeys: String, CodingKey {
        case street1, street2, city, state, country, postalcode
        case addressString = "address_string"
    }
}



