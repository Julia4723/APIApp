//
//  Something.swift
//  APIApp
//
//  Created by user on 07.04.2024.
//

import Foundation

struct Something: Decodable {
    let latitude: String
    let longitude: String
    let accuracy: Int
    let timezone: String
    let countryСode: String
    let organization: String
    let asn: Int
    let ip: String
    let areaСode: String
    let organizationName: String
    let city: String
    let countryCode3: String
    let continentCode: String
    let country: String
    let region: String
    
    
    enum CodingKeys: String, CodingKey{
        case latitude = "latitude"
        case longitude = "longitude"
        case accuracy = "accuracy"
        case timezone = "timezone"
        case countryСode = "countryСode"
        case organization = "organization"
        case asn = "asn"
        case ip = "ip"
        case areaСode = "areaСode"
        case organizationName = "organizationName"
        case city = "city"
        case countryCode3 = "countryCode3"
        case continentCode = "continentCode"
        case country = "country"
        case region = "region"
        
        
    }
}
