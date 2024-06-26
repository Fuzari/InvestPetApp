//
//  RequestExecutor.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 26.06.2024.
//

import Foundation

final class RequestExecutor {
    
    func execute<T: Responsable & Decodable>(_ request: URLRequest, for model: T.Type) async throws -> [T.Model] {
        let (data, _) = try await URLSession.shared.data(for: request)
        let model = try JSONDecoder().decode(model.self, from: data)
        return model.models
    }
}
