//
//  FinalReservationModel.swift
//  airbnb
//
//  Created by 박정하 on 2021/06/04.
//

import Foundation

struct ReservationModel: Decodable {
    var priceForDays: Int
    var cleaningFee: Int
    var serviceFee: Int
    var tax: Int
    var totalPrice: Int
    
    static var empty = Self.init()
    
    init() {
        self.priceForDays = 0
        self.cleaningFee = 0
        self.serviceFee = 0
        self.tax = 0
        self.totalPrice = 0
    }
}
