//
//  MockData.swift
//  Trips
//
//  Created by Atakan Başaran on 3.07.2024.
//

import Foundation

struct MockData {
    
    static let mockLocationDetail = LocationDetailsModel(locationID: "17839937", name: "Bursa Birlik Hotel", description: "hotel", webURL: "https://www.tripadvisor.com/Hotel_Review-g297977-d17839937-Reviews-Bursa_Birlik_Hotel-Bursa.html?m=66827", addressObj: .init(street1: "", street2: "", city: "", state: "", country: "", postalcode: "", addressString: ""), ancestors: [.init(level: "City", name: "Bursa", locationID: "297977")], latitude: "40.27", longitude: "28.96", timezone: "", email: "", phone: "", website: "", writeReview: "", rankingData: .init(geoLocationID: "", rankingString: "", geoLocationName: "", rankingOutOf: "63", ranking: "35"), rating: "3.5", ratingImageURL: "https://www.tripadvisor.com/img/cdsi/img2/ratings/traveler/3.5-66827-5.svg", numReviews: "2", reviewRatingCount: .none, subratings: .none, photoCount: "0", seeAllPhotos: "", priceLevel: "$", hours: .none, features: [""], cuisine: [.init(name: "", localizedName: "")], category: .init(name: "hotel", localizedName: ""), subcategory: [.init(name: "hotel", localizedName: "")], neighborhoodInfo: [""], tripTypes: [], awards: [])
    
    
    static let mockImageModel = LocationImageModel(data: [.init(id: 725569556, isBlessed: false, caption: "", publishedDate: "", images: .init(thumbnail: .init(height: 50, width: 50, url: ""), small: .init(height: 150, width: 150, url: ""), medium: .init(height: 200, width: 180, url: ""), large: .init(height: 450, width: 338, url: ""), original: .init(height: 1365, width: 1024, url: "https://media-cdn.tripadvisor.com/media/photo-m/1280/2b/3f/50/14/caption.jpg")), album: "Other", source: .init(name: "Traveler", localizedName: "Traveler"), user: .init(username: "Ata"))], paging: .none)
}
