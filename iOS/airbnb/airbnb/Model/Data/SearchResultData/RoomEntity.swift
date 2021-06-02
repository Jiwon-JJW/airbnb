//
//  RoomData.swift
//  airbnb
//
//  Created by 박정하 on 2021/05/24.
//

import Foundation

struct RoomEntity: Decodable {
    
    private(set) var propertyId: Int
    private(set) var images: String
    private(set) var title: String
    private(set) var bookmark: Bool
    private(set) var pricePerNight: Int
    private(set) var totalPrice: Int
    private(set) var reviewCount: Int
    private(set) var rating: Double
    private(set) var latitude: Double
    private(set) var longitude: Double
    
    var priceDescription: String {
        return "\(pricePerNight.decimalWon()) /박"
    }

    var totalPriceDescription: String {
        return "총액 \(totalPrice.decimalWon())"
    }
    
    var reviewCountDescription: String {
        return "후기 \(reviewCount)개"
    }
    
    var ratingDescription: String {
        return "\(rating)"
    }
}

extension Int {
    func decimalWon() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = "₩" + numberFormatter.string(from: NSNumber(value: self))!
        return result
    }
}
