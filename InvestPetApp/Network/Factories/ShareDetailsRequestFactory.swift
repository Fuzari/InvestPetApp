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
    static let token = "t.L8UWFin0Kkc9bmdatEA24Av096x_279VfN05JkMI2kz_t4P7eEIgikCw6YvhCfPrMbSoe_ceLbpU22un3UJqCw"
    static let authorizationHeaderValue = "Bearer \(String.token)"
    static let protocolHeader = "Sec-WebSocket-Protocol"
    static let protocolValue = "json"
}

final class ShareDetailsRequestFactory {
    
    func makeRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = .httpMethod
        request.addValue(.authorizationHeaderValue, forHTTPHeaderField: .authorizationHeader)
        request.addValue(.protocolValue, forHTTPHeaderField: .protocolHeader)
        return request
    }
}
