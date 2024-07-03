//
//  LocationDetailsModel.swift
//  Trips
//
//  Created by Atakan Başaran on 2.07.2024.
//

import Foundation

import Foundation

import Foundation

struct LocationDetailsModel: Codable {
    let locationID: String
    let name: String
    let description: String?
    let webURL: String
    let addressObj: AddressObj
    let ancestors: [Ancestor]?
    let latitude: String?
    let longitude: String?
    let timezone: String?
    let email: String?
    let phone: String?
    let website: String?
    let writeReview: String?
    let rankingData: RankingData?
    let rating: String?
    let ratingImageURL: String?
    let numReviews: String?
    let reviewRatingCount: ReviewRatingCount?
    let subratings: Subratings?
    let photoCount: String?
    let seeAllPhotos: String?
    let priceLevel: String?
    let hours: Hours?
    let features: [String]?
    let cuisine: [Cuisine]?
    let category: Category?
    let subcategory: [Subcategory]?
    let neighborhoodInfo: [String]?
    let tripTypes: [TripType]?
    let awards: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case locationID = "location_id"
        case name
        case description
        case webURL = "web_url"
        case addressObj = "address_obj"
        case ancestors, latitude, longitude, timezone, email, phone, website
        case writeReview = "write_review"
        case rankingData = "ranking_data"
        case rating
        case ratingImageURL = "rating_image_url"
        case numReviews = "num_reviews"
        case reviewRatingCount = "review_rating_count"
        case subratings
        case photoCount = "photo_count"
        case seeAllPhotos = "see_all_photos"
        case priceLevel = "price_level"
        case hours, features, cuisine, category, subcategory
        case neighborhoodInfo = "neighborhood_info"
        case tripTypes = "trip_types"
        case awards
    }
}


struct Ancestor: Codable {
    let level: String?
    let name: String?
    let locationID: String?

    enum CodingKeys: String, CodingKey {
        case level, name
        case locationID = "location_id"
    }
}

struct RankingData: Codable {
    let geoLocationID: String?
    let rankingString: String?
    let geoLocationName: String?
    let rankingOutOf: String?
    let ranking: String?

    enum CodingKeys: String, CodingKey {
        case geoLocationID = "geo_location_id"
        case rankingString = "ranking_string"
        case geoLocationName = "geo_location_name"
        case rankingOutOf = "ranking_out_of"
        case ranking
    }
}

struct ReviewRatingCount: Codable {
    let one: String?
    let two: String?
    let three: String?
    let four: String?
    let five: String?

    enum CodingKeys: String, CodingKey {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
    }
}

struct Subratings: Codable {}

struct Hours: Codable {
    let periods: [Period]?
    let weekdayText: [String]?

    enum CodingKeys: String, CodingKey {
        case periods
        case weekdayText = "weekday_text"
    }
}

struct Period: Codable {
    let open: OpenClose?
    let close: OpenClose?
}

struct OpenClose: Codable {
    let day: Int?
    let time: String?
}

struct Cuisine: Codable {
    let name: String?
    let localizedName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

struct Category: Codable {
    let name: String?
    let localizedName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

struct Subcategory: Codable {
    let name: String?
    let localizedName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
    }
}

struct TripType: Codable {
    let name: String?
    let localizedName: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localizedName = "localized_name"
        case value
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
