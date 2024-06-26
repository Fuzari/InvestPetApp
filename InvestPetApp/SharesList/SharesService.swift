//
//  SharesService.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 21.06.2024.
//

import Foundation

final class SharesService: NSObject {
    
    private let executor = RequestExecutor()
    private let requestsFactory = InvestRequestFactory()
    private let urlFactory = InvestURLFactrory()
    
    func loadShares() async throws -> [InstrumentModel] {
        let url = try urlFactory.makeFindIntrumentURL()
        let request = try requestsFactory.makeFindInstrumentsRequest(with: url)
        let models = try await executor.execute(request, for: InstrumentsResponseModel.self)
        return models
    }
}
