//
//  HostModel.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/01.
//

import Foundation

struct Host: Decodable {
    let name: String
    let imageUrl: String
    
    var nameDescription: String {
        return "호스트: \(name)"
    }
    
    static var empty = Self.init(name: "", imageUrl: "")
}
