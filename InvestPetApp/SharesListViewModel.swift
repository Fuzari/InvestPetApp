//
//  SharesListViewModel.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 20.06.2024.
//

import Foundation

final class SharesListViewModel: ObservableObject {
    @Published var sharesList: [ShareModel] = []
    
    func loadShares() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.sharesList = [
                ShareModel(name: "TBank"),
                ShareModel(name: "VTB"),
                ShareModel(name: "Sovcombank")
            ]
        }
    }
}


struct ShareModel: Identifiable {
    var id: UUID = UUID()
    var name = "Sber"
}
