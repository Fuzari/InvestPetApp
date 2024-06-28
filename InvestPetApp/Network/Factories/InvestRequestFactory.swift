//
//  InvestRequestFactory.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 26.06.2024.
//

import Foundation

private extension String {
    static let token = "t.L8UWFin0Kkc9bmdatEA24Av096x_279VfN05JkMI2kz_t4P7eEIgikCw6YvhCfPrMbSoe_ceLbpU22un3UJqCw"
    static let authorizationHeader = "Authorization"
    static let authorizationValue = "Bearer \(String.token)"
    static let contentTypeHeader = "Content-Type"
    static let contentTypeValue = "application/json"
    static let acceptHeader = "accept"
}

final class InvestRequestFactory {
    
    func makeFindInstrumentsRequest(with url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(.authorizationValue, forHTTPHeaderField: .authorizationHeader)
        request.addValue(.contentTypeValue, forHTTPHeaderField: .contentTypeHeader)
        request.addValue(.contentTypeValue, forHTTPHeaderField: .acceptHeader)
        
        let json: [String: Any] = [
            "query": "Сбер Банк",
            "instrumentKind": "INSTRUMENT_TYPE_SHARE",
            "apiTradeAvailableFlag": true
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        return request
    }
}
