//
//  LastPriceResponseModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 03.07.2024.
//

import Foundation

struct Price: Codable {
    let units: String
    let nano: Int
}

struct LastPrice: Codable {
    let figi: String
    let price: Price
    let time: String
    let instrumentUid: String
}

struct LastPriceResponse: Codable {
    let lastPrice: LastPrice
}
