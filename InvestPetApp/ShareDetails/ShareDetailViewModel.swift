//
//  ShareDetailViewModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import Foundation
import Combine

@MainActor final class ShareDetailViewModel: ObservableObject {
    
    // Dependencies
    private let shareDetailsService: ShareDetailsService
    
    // Private
    private var cancellables = Set<AnyCancellable>()
    
    @Published var shareDetailModel: ShareDetailModel = .empty(model: EmptyModel(title: "Данных пока нет."))
    
    // MARK: - Initialization
    
    init(shareDetailsService: ShareDetailsService) {
        self.shareDetailsService = shareDetailsService
    }
    
    // MARK: - Internal
    
    func onAppear() {
        setupBindings()
        
        Task {
            await loadShareDetails()
        }
    }
    
    func cancelConnection() {
        shareDetailsService.cancelConnection()
    }
    
    // MARK: - Private
    
    private func loadShareDetails() async {
        do {
            try await shareDetailsService.loadShareDetails()
        } catch {
            print(error)
        }
    }
    
    private func setupBindings() {
        shareDetailsService.$lastPrice
            .receive(on: RunLoop.main)
            .sink { [weak self] lastPrice in
                self?.handle(published: lastPrice)
            }
            .store(in: &cancellables)
    }
    
    private func handle(published value: Published<LastPrice?>.Publisher.Output) {
        guard let value else {
            shareDetailModel = .empty(model: EmptyModel(title: "Данных пока нет."))
            return
        }
        
        shareDetailModel = .data(model: value)
    }
}


enum ShareDetailModel {
    case empty(model: EmptyModel)
    case data(model: LastPrice)
}

struct EmptyModel {
    let title: String
}
