//
//  SharesListViewModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 20.06.2024.
//

import Foundation

@MainActor final class SharesListViewModel: ObservableObject {
    @Published var instrumentsList: [InstrumentModel] = []
    
    private let sharesService = SharesService()
    
    func loadShares() {
        Task {
            do {
                instrumentsList = try await sharesService.loadShares()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
