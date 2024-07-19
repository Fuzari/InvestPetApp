//
//  SharesListViewModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 20.06.2024.
//

import Foundation

@MainActor final class SharesListViewModel: ObservableObject {
    
    // Internal
    @Published var instrumentsList: [InstrumentModel] = []
    
    // Dependencies
    private let sharesListService: SharesListService
    
    init(token: String) {
        sharesListService = SharesListService(token: token)
    }
    
    // MARK: - Internal
    
    func loadShares() {
        Task {
            do {
                instrumentsList = try await sharesListService.loadShares()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
