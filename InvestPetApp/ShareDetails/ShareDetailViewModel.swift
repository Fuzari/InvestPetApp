//
//  ShareDetailViewModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import Foundation

@MainActor final class ShareDetailViewModel: ObservableObject {
    
    private let shareDetailsService = ShareDetailsService()
    
    func loadShareDetails() {
        Task {
            do {
                try await shareDetailsService.loadShareDetails()
            } catch {
                print(error)
            }
        }
    }
}
