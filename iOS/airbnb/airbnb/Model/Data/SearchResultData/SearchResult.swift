//
//  SearchResultData.swift
//  airbnb
//
//  Created by 박정하 on 2021/05/24.
//

import Foundation

struct SearchResult: Decodable {
    private(set) var properties: [RoomEntity]
    
    init(properties: [RoomEntity]) {
        self.properties = properties
    }
}
