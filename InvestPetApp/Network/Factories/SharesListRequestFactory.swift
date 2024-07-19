//
//  SharesListRequestFactory..swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 26.06.2024.
//

import Foundation

private extension String {
    static let authorizationHeader = "Authorization"
    static let authorizationValue = "Bearer"
    static let contentTypeHeader = "Content-Type"
    static let contentTypeValue = "application/json"
    static let acceptHeader = "accept"
}

final class SharesListRequestFactory {
    
    // Private
    private let token: String
    
    // MARK: - Initialization
    
    init(token: String) {
        self.token = token
    }
    
    func makeRequest(with url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(String.authorizationValue) \(token)", forHTTPHeaderField: .authorizationHeader)
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
