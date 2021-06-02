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
    
    var priceDescription: String {
        return "\(pricePerNight)"
    }
    
    var reviewCountDescription: String {
        return "후기 \(reviewCount)개"
    }
    
    var ratingDescription: String {
        return "\(rating)"
    }
    
    func decimalWon(value: String) -> String {
        let price = Int(value.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "원", with: "")) ?? 0
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: price))! + "원"
        
        return result
    }
}
