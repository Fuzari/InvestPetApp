//
//  InvestURLFactrory.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 26.06.2024.
//

import Foundation

private extension String {
    static let mainURL = "https://invest-public-api.tinkoff.ru/rest"
    static let servicePath = "tinkoff.public.invest.api.contract.v1.InstrumentsService/FindInstrument"
}

final class InvestURLFactrory {
    
    func makeFindIntrumentURL() throws -> URL {
        let urlString: String = "\(String.mainURL)/\(String.servicePath)"
        guard let url = URL(string: urlString) else {
            throw NSError()
        }
        
        return url
    }
}
