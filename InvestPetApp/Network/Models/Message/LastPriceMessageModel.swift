//
//  LastPriceMessageModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 03.07.2024.
//

import Foundation

struct SubscribeLastPriceMessageWrapper: Codable {
    let subscribeLastPriceRequest: SubscribeLastPriceMessage
}

// Модель данных подписки на последнюю цену
struct SubscribeLastPriceMessage: Codable {
    let subscriptionAction: String
    let instruments: [Instrument]
}

// Модель инструмента
struct Instrument: Codable {
    let instrumentId: String
}
