//
//  ShareDetailsService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import Foundation

final class ShareDetailsService: NSObject, ObservableObject, URLSessionWebSocketDelegate {
    
    // Dependencies
    private let urlFactory = ShareDetailsURLFactory()
    private let requestFactory = ShareDetailsRequestFactory()
    
    // Private
    private var socket: URLSessionWebSocketTask?
    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    private var isConnected = false
    private let shareId: String
    
    @Published var lastPrice: LastPrice?
    
    // MARK: - Initialization
    
    init(shareId: String) {
        self.shareId = shareId
    }
    
    // MARK: - Internal
    
    func loadShareDetails() async throws {
        guard !isConnected else { return }
        try createTask()
        try await receiveData()
    }
    
    func cancelConnection() {
        socket?.cancel()
        isConnected = false
    }
    
    // MARK: - URLSessionWebSocketDelegate
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        isConnected = true
        do {
            try sendData()
        } catch {
            print(error)
        }
        print("Connection is opened.")
    }
    
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        isConnected = false
        print("Connection was closed. Close code: \(closeCode).)")
    }
    
    // MARK: - Private
    
    private func createTask() throws {
        let url = try urlFactory.makeURL()
        let request = requestFactory.makeRequest(with: url)
        socket = urlSession.webSocketTask(with: request)
        socket?.resume()
    }
    
    private func sendData() throws {
        let model = SubscribeLastPriceMessageWrapper(
            subscribeLastPriceRequest: SubscribeLastPriceMessage(
                subscriptionAction: "SUBSCRIPTION_ACTION_SUBSCRIBE",
                instruments: [Instrument(instrumentId: shareId)]
            )
        )
        
        let message: Data?
        do {
            message = try JSONEncoder().encode(model)
        } catch {
            throw ServicesError.dataEncodingError
        }
        
        guard let message else { return }
        Task {
            try await socket?.send(.data(message))
        }
    }
    
    private func receiveData() async throws {
        let message = try await socket?.receive()
        
        guard isConnected else { return }
        switch message {
        case .string(let data):
            try handleMessage(from: data)
        default:
            throw ServicesError.unexpectedFrameData
        }
        try await receiveData()
    }
    
    private func handleMessage(from string: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw ServicesError.messageEncodingError
        }
        
        
        if let model = try? JSONDecoder().decode(SubscribeLastPriceResponseWrapper.self, from: data) {
            print(model)
        } else if let model = try? JSONDecoder().decode(LastPriceResponse.self, from: data) {
            lastPrice = model.lastPrice
            print(model)
        } else {
            throw ServicesError.messageDecodingError
        }
    }
}

enum ServicesError: Error {
    case unexpectedFrameData
    case dataEncodingError
    case messageEncodingError
    case messageDecodingError
    case creatingURLError
}
