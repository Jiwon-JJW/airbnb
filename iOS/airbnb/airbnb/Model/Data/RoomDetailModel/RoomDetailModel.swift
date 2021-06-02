//
//  RoomDetailModel.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/01.
//

import Foundation

struct RoomDetailModel: Decodable {
    let roomImage: [String]
    let title: String
    let description: String
    let location: String
    let host: Host
    let type: String
    
    let bed_count: Int //need CodingKey?
    let bath_cont: Int
    let max_occupancy: Int //need CodingKey?
    
    let rating: Double
    let reviewCount: Int
    let pricePerNight: Int
    let cleaningFee: Int
    let latitude: Double
    let longtitude: Double
    
    let occupied_date: [String] //need?
}
