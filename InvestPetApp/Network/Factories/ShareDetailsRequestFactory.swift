//
//  ShareDetailsRequestFactory.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 10.07.2024.
//

import Foundation

private extension String {
    static let httpMethod = "GET"
    static let authorizationHeader = "Authorization"
    static let authorizationHeaderValue = "Bearer"
    static let protocolHeader = "Sec-WebSocket-Protocol"
    static let protocolValue = "json"
}

final class ShareDetailsRequestFactory {
    
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func makeRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = .httpMethod
        request.addValue("\(String.authorizationHeaderValue) \(token)", forHTTPHeaderField: .authorizationHeader)
        request.addValue(.protocolValue, forHTTPHeaderField: .protocolHeader)
        return request
    }
}
