//
//  ShareDetailsService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import Foundation

private extension String {
    static let host = "wss://invest-public-api.tinkoff.ru"
    static let subURL = "/ws/tinkoff.public.invest.api.contract.v1.MarketDataStreamService/MarketDataStream"
    static let token = "t.L8UWFin0Kkc9bmdatEA24Av096x_279VfN05JkMI2kz_t4P7eEIgikCw6YvhCfPrMbSoe_ceLbpU22un3UJqCw"
    static let protocolHeader = "Sec-WebSocket-Protocol"
    static let protocolValue = "json"
}

final class ShareDetailsService: NSObject {
    
    private var task: URLSessionWebSocketTask?
    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    func loadShareDetails() async throws {
        try createTask()
        try await ping()
    }
    
    func cancelConnection() {
        task?.cancel(with: .goingAway, reason: nil)
    }
    
    private func createTask() throws {
        guard let url = URL(string: "\(String.host)\(String.subURL)") else {
            throw NSError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
//        request.addValue(.protocolValue, forHTTPHeaderField: "\(String.protocolHeader), \(String.token)")
        
        task = urlSession.webSocketTask(with: request)
    }
    
    private func sendData() async throws {
        let json = [
            "subscribeLastPriceRequest": [
                "subscriptionAction": "SUBSCRIPTION_ACTION_SUBSCRIBE",
                "instruments": [
                    ["instrumentId": "e6123145-9665-43e0-8413-cd61b8aa9b13"]
                ]
            ]
        ]
        
        let data = try JSONSerialization.data(withJSONObject: json)
        
        try await task?.send(.data(data))
    }
    
    private func receiveData() async throws {
        let message = try await task?.receive()
        
        switch message {
        case .string(let string):
            print(string)
        case .data(let data):
            print(data)
        default:
            fatalError("Получено неожиданное сообщение.")
     
        }
        try await receiveData()
    }
    
    private func ping() async throws{
        let serverDateFormatter: DateFormatter = {
            let result = DateFormatter()
            result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
            result.timeZone = .current
            return result
        }()
        
        let date = serverDateFormatter
        
        let json = [
            "ping": [
                "time": serverDateFormatter.string(from: Date())
            ]
        ]
        
        let data = try JSONSerialization.data(withJSONObject: json)
        
        try await task?.send(.data(data))
        try await ping()
    }
}

extension ShareDetailsService: URLSessionDelegate {
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        print("Connection is opened.")
    }
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        print("Connection was closed.")
    }
}
