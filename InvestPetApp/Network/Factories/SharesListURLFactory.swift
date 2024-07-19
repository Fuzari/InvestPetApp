//
//  SharesListURLFactory.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 26.06.2024.
//

import Foundation

private extension String {
    static let url = "https://invest-public-api.tinkoff.ru/rest/tinkoff.public.invest.api.contract.v1.InstrumentsService/FindInstrument"
}

final class SharesListURLFactory {
    
    func makeURL() throws -> URL {
        guard let url = URL(string: .url) else {
            throw NSError()
        }
        
        return url
    }
}
