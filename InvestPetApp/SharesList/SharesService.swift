//
//  SharesService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 21.06.2024.
//

import Foundation

private enum Constants {
    static let mainURL = "https://invest-public-api.tinkoff.ru/rest"
    static let servicePath = "tinkoff.public.invest.api.contract.v1.InstrumentsService/FindInstrument"
    static let token = "t.L8UWFin0Kkc9bmdatEA24Av096x_279VfN05JkMI2kz_t4P7eEIgikCw6YvhCfPrMbSoe_ceLbpU22un3UJqCw"
}

final class SharesService: NSObject {
    
    func loadShares() async throws -> [InstrumentModel] {
        
        let urlString: String = "\(Constants.mainURL)/\(Constants.servicePath)"
        guard let url = URL(string: urlString) else {
            throw NSError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Constants.token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let json: [String: Any] = [
            "query": "Сбер Банк",
            "instrumentKind": "INSTRUMENT_TYPE_SHARE",
            "apiTradeAvailableFlag": true
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let model = try JSONDecoder().decode(ResponseModel.self, from: data)
        return model.instruments
    }
}

struct ResponseModel: Decodable {

    let instruments: [InstrumentModel]
}

struct InstrumentModel: Decodable, Identifiable {
    
    enum InstrumentKind: String {
        case share = "INSTRUMENT_TYPE_SHARE"
    }
    
    let id = UUID()
    let name: String
    let ticker: String
    let instrumentKind: InstrumentKind?
    
    enum CodingKeys: String, CodingKey {
        case name
        case ticker
        case instrumentKind
    }
    
    init (from decoder :Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        ticker = try container.decode(String.self, forKey: .ticker)
        let kindValue = try container.decode(String.self, forKey: .instrumentKind)
        instrumentKind = InstrumentKind(rawValue: kindValue)
    }
}


let responseModel = """
    {
        apiTradeAvailableFlag = 1;
        blockedTcaFlag = 0;
        classCode = TQBR;
        figi = BBG004730N88;
        first1dayCandleDate = "2000-01-04T07:00:00Z";
        first1minCandleDate = "2018-03-07T18:33:00Z";
        forIisFlag = 1;
        forQualInvestorFlag = 0;
        instrumentKind = "INSTRUMENT_TYPE_SHARE";
        instrumentType = share;
        isin = RU0009029540;
        name = "Сбербанк";
        positionUid = "41eb2102-5333-4713-bf15-72b204c4bf7b";
        ticker = SBER;
        uid = "e6123145-9665-43e0-8413-cd61b8aa9b13";
        weekendFlag = 1;
    }
"""
