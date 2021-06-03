//
//  RoomDetailModel.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/01.
//

import Foundation

struct RoomDetailModel: Decodable {
    let imageUrls: [String]
    let title: String
    let description: String
    let locationName: String
    let host: Host
    let propertyType: String
    
    let bedCount: Int //need CodingKey?
    let bathCount: Int
    let maxOccupancy: Int //need CodingKey?
    
    let rating: Double
    let reviewCount: Int
    let pricePerNight: Int
    let cleaningFee: Int
    let latitude: Double
    let longitude: Double
    
    var bedCountDescription: String {
        return "침대 \(bedCount)개"
    }
    
    var bathCoutDescription: String {
        return "욕실 \(bathCount)개"
    }
    
    var maxOccupancyDesscription: String {
        return "최대인원 \(maxOccupancy)명"
    }
    
    var ratingDescription: String {
        return "\(rating)"
    }
    
    var reviewCountDescription: String {
        return "(후기 \(reviewCount)개)"
    }
    
    var priceDescription: String {
        return "\(pricePerNight.decimalWon()) /박"
    }
    
    static var empty = Self.init(imageUrls: [], title: "", description: "", locationName: "", host: Host.empty, propertyType: "", bedCount: 0, bathCount: 0, maxOccupancy: 0, rating: 0, reviewCount: 0, pricePerNight: 0, cleaningFee: 0, latitude: 0, longitude: 0)
}
