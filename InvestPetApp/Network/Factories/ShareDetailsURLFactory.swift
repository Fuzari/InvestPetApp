//
//  ShareDetailsURLFactory.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 10.07.2024.
//

import Foundation

private extension String {
    static let url = "wss://invest-public-api.tinkoff.ru/ws/tinkoff.public.invest.api.contract.v1.MarketDataStreamService/MarketDataStream"
}

final class ShareDetailsURLFactory {
    
    func makeURL() throws -> URL {
        guard let url = URL(string: .url) else {
            throw NSError()
        }
        
        return url
    }
}
