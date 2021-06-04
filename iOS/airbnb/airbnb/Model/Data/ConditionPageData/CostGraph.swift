//
//  CostGraph.swift
//  airbnb
//
//  Created by 심영민 on 2021/05/26.
//

import Foundation

struct CostGraph: Decodable {
    private (set) var averagePrice: Int
    private (set) var numberOfRooms: [Int]
    
    var averagePriceDescription: String {
        return "평균 1박 요금은 \(averagePrice.decimalWon()) 입니다."
    }
}
