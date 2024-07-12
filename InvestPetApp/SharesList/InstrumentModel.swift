//
//  InstrumentModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 26.06.2024.
//

import Foundation

struct InstrumentModel: Decodable, Identifiable, Hashable {
    
    enum InstrumentKind: String {
        case share = "INSTRUMENT_TYPE_SHARE"
    }
    
    let id: String
    let name: String
    let ticker: String
    let instrumentKind: InstrumentKind?
    
    enum CodingKeys: String, CodingKey {
        case name
        case ticker
        case instrumentKind
        case uid
    }
    
    init(from decoder :Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .uid)
        name = try container.decode(String.self, forKey: .name)
        ticker = try container.decode(String.self, forKey: .ticker)
        let kindValue = try container.decode(String.self, forKey: .instrumentKind)
        instrumentKind = InstrumentKind(rawValue: kindValue)
    }
    
    init() {
        id = ""
        name = "ShareName"
        ticker = "Ticker"
        instrumentKind = nil
    }
}
