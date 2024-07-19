//
//  SharesListService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 21.06.2024.
//

import Foundation

final class SharesListService: NSObject {
    
    // Dependencies
    private let executor = RequestExecutor()
    private let requestsFactory: SharesListRequestFactory
    private let urlFactory = SharesListURLFactory()
    
    // MARK: - Initialization
    
    init(token: String) {
        requestsFactory = SharesListRequestFactory(token: token)
    }
    
    // MARK: - Internal
    
    func loadShares() async throws -> [InstrumentModel] {
        let url = try urlFactory.makeURL()
        let request = try requestsFactory.makeRequest(with: url)
        let models = try await executor.execute(request, for: InstrumentsResponseModel.self)
        return models
    }
}
