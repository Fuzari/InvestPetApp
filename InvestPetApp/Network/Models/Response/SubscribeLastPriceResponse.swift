//
//  SubscribeLastPriceResponse.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 03.07.2024.
//

import Foundation

struct LastPriceSubscription: Codable {
    let figi: String
    let subscriptionStatus: String
    let instrumentUid: String
    let streamId: String
    let subscriptionId: String
}

struct SubscribeLastPriceResponse: Codable {
    let trackingId: String
    let lastPriceSubscriptions: [LastPriceSubscription]
}

struct SubscribeLastPriceResponseWrapper: Codable {
    let subscribeLastPriceResponse: SubscribeLastPriceResponse
}
