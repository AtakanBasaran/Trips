//
//  LocationImageModel.swift
//  Trips
//
//  Created by Atakan Başaran on 3.07.2024.
//

import Foundation

struct LocationImageModel: Codable {
    
    let data: [LocationImage]?
    let paging: Paging?
}

struct LocationImage: Codable {
    let id: Int
    let isBlessed: Bool?
    let caption: String?
    let publishedDate: String?
    let images: Images
    let album: String?
    let source: Source?
    let user: User?

    

    enum CodingKeys: String, CodingKey {
        case id
        case isBlessed = "is_blessed"
        case caption
        case publishedDate = "published_date"
        case images
        case album
        case source
        case user
    }
}

struct Images: Codable {
    let thumbnail: ImageInfo?
    let small: ImageInfo?
    let medium: ImageInfo?
    let large: ImageInfo?
    let original: ImageInfo?

    struct ImageInfo: Codable {
        let height: Int
        let width: Int
        let url: String
    }
}

struct Source: Codable {
    let name: String
    let localizedName: String

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

struct User: Codable {
    let username: String
}

struct Paging: Codable {
    // Define any relevant properties for the paging object
}
