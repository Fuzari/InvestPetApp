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
    private var sub: AnyCancellable?
    
    @Published var shareDetailModel: ShareDetailModel = .empty(model: EmptyModel(title: "Данных пока нет."))
    
    func loadShareDetails() {
        let sub = shareDetailsService.$lastPrice.sink { [weak self] model in
            switch model {
            case .some(let lastPrice):
                self?.shareDetailModel = .data(model: lastPrice)
            case .none:
                return
            }
        }
        
        Task {
            do {
                try await shareDetailsService.loadShareDetails()
            } catch {
                print(error)
            }
        }
    }
}


enum ShareDetailModel {
    case empty(model: EmptyModel)
    case data(model: LastPrice)
}

struct EmptyModel {
    let title: String
}
