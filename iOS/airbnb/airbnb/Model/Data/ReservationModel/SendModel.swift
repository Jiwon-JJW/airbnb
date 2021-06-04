//
//  sendModel.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/04.
//

import Foundation

struct SendModel {
    var propertyId: Int
    var checkin : String
    var checkout : String
    var guestCount : Int
    
    static var empty = Self.init()
    
    init() {
        self.propertyId = 1
        self.checkin = ""
        self.checkout = ""
        self.guestCount = 0
    }
}
