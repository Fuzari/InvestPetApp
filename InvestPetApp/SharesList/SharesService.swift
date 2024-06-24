//
//  SharesService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 21.06.2024.
//

import Foundation

private enum Constants {
    static let mainURL = "https://invest-public-api.tinkoff.ru/rest"
    static let servicePath = "tinkoff.public.invest.api.contract.v1.InstrumentService/FindInstrument"
    static let token = "t.L8UWFin0Kkc9bmdatEA24Av096x_279VfN05JkMI2kz_t4P7eEIgikCw6YvhCfPrMbSoe_ceLbpU22un3UJqCw"
}

final class SharesService {
    
    func loadShares() async throws {
        
        let urlString: String = "\(Constants.mainURL)/\(Constants.servicePath)"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Constants.token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let json = """
            {
              "query": "Cбер Банк",
              "instrumentKind": "INSTRUMENT_TYPE_SHARE",
              "apiTradeAvailableFlag": true
            }
        """
        
        let jsonData = Data(json.utf8)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print(response)
        print(data)
    }
}
