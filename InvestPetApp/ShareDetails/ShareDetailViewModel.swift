//
//  ShareDetailViewModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import Foundation
import Combine

@MainActor final class ShareDetailViewModel: ObservableObject {
    
    private let shareDetailsService = ShareDetailsService()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var shareDetailModel: ShareDetailModel = .empty(model: EmptyModel(title: "Данных пока нет."))
    
    func loadShareDetails() {
        setupBindings()
        
        Task {
            do {
                try await shareDetailsService.loadShareDetails()
            } catch {
                print(error)
            }
        }
    }
    
    func cancelConnection() {
        shareDetailsService.cancelConnection()
    }
    
    private func setupBindings() {
            // Устанавливаем подписку на изменения lastPrice из сервиса
        shareDetailsService.$lastPrice
                // Убедимся, что обновление идет в основном потоке, так как мы обновляем UI
                .receive(on: RunLoop.main)
                // Наблюдаем за изменениями
                .sink { [weak self] newLastPrice in
                    // Обновляем shareDetailModel, когда получаем новое значение lastPrice
                    self?.shareDetailModel = newLastPrice != nil ? .data(model: newLastPrice!) : .empty(model: EmptyModel(title: "Данных пока нет."))
                }
                // Сохраняем подписку
                .store(in: &cancellables)
        }
}


enum ShareDetailModel {
    case empty(model: EmptyModel)
    case data(model: LastPrice)
}

struct EmptyModel {
    let title: String
}
