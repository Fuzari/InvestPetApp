//
//  ShareDetailsService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import Foundation

private extension String {
    static let host = "wss://invest-public-api.tinkoff.ru/ws"
    static let subURL = "/tinkoff.public.invest.api.contract.v1.MarketDataStreamService/MarketDataStream"
    static let token = "t.L8UWFin0Kkc9bmdatEA24Av096x_279VfN05JkMI2kz_t4P7eEIgikCw6YvhCfPrMbSoe_ceLbpU22un3UJqCw"
    static let protocolHeader = "Sec-WebSocket-Protocol"
    static let protocolValue = "json"
}

final class ShareDetailsService: NSObject {
    
    private var socket: URLSessionWebSocketTask?
    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    private var task: Task<Void, Error>?
    private var isConnected = false
    
    deinit {
        socket?.cancel()
        socket = nil
    }
    
    func loadShareDetails() async throws {
        try createTask()
        socket?.resume()
//        try await sendData()
//        try await ping()
        try await receiveData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.cancelConnection()
        }
    }
    
    func cancelConnection() {
        socket?.cancel(with: .goingAway, reason: nil)
    }
    
    private func createTask() throws {
        guard let url = URL(string: "\(String.host)\(String.subURL)") else {
            throw NSError()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(String.token)", forHTTPHeaderField: "Authorization")
        request.addValue("json", forHTTPHeaderField: "Sec-WebSocket-Protocol")
        
        socket = urlSession.webSocketTask(with: request)
    }
    
    private func sendData() {
        let model = SubscribeLastPriceRequestWrapper(
            subscribeLastPriceRequest: SubscribeLastPriceRequest(
                subscriptionAction: "SUBSCRIPTION_ACTION_SUBSCRIBE",
                instruments: [Instrument(instrumentId: "e6123145-9665-43e0-8413-cd61b8aa9b13")]
            )
        )
        
        let data: Data?
        do {
            data = try JSONEncoder().encode(model)
        } catch {
            print(error.localizedDescription)
            return
        }
        
        guard let data else { return }
        Task {
            try await socket?.send(.data(data))
        }
    }
    
    private func receiveData() async throws {
        let message = try await socket?.receive()
        
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
    
    private func ping() async throws {
        guard isConnected else { return }
        let serverDateFormatter: DateFormatter = {
            let result = DateFormatter()
            result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
            result.timeZone = .current
            return result
        }()
        
        print(serverDateFormatter.string(from: Date()))
        
        let json = [
            "ping": [
                "time": serverDateFormatter.string(from: Date())
            ]
        ]
        
        let data = try JSONSerialization.data(withJSONObject: json)
        
        task = Task {
            guard let task, !task.isCancelled else { return }
            try await Task.sleep(nanoseconds: 50_000_000) // 50 ms
            try await socket?.send(.data(data))
            try await ping()
        }
    }
}

extension ShareDetailsService: URLSessionWebSocketDelegate {
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        print("Connection is opened.")
        isConnected = true
        sendData()
    }
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        let reason = String(data: reason!, encoding: .utf8)
        print("Connection was closed. Close code: \(closeCode). Reason: \(String(describing: reason))")
        isConnected = false
        task?.cancel()
    }
}

struct SubscribeLastPriceRequestWrapper: Codable {
    let subscribeLastPriceRequest: SubscribeLastPriceRequest
}

// Модель данных подписки на последнюю цену
struct SubscribeLastPriceRequest: Codable {
    let subscriptionAction: String
    let instruments: [Instrument]
}

// Модель инструмента
struct Instrument: Codable {
    let instrumentId: String
}
