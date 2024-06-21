//
//  SharesService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 21.06.2024.
//

import Foundation

private enum Constants {
    static let mainURL = "wss://invest-public-api.tinkoff.ru/ws/"
    static let 
    static let protocolHeaderName = "Web-Socket-Protocol"
    static let protocolHeaderValue = "json"
}

final class SharesService {
    
    let urlSession = URLSession(configuration: .default)
    
    func loadShares() {
        let task = urlSession.webSocketTask(with: <#T##URL#>)
    }
}
