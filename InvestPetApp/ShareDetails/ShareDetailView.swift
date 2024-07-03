//
//  ShareDetailView.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import SwiftUI

struct ShareDetailView: View {
    
    @ObservedObject var viewModel: ShareDetailViewModel
    
    var body: some View {
        
        switch viewModel.shareDetailModel {
        case .data(model: let lastPrice):
            VStack {
                Text(lastPrice.price.units)
                Text(lastPrice.time)
            }
        case .empty(model: let emptyModel):
            Text(emptyModel.title)
                .task {
                    viewModel.loadShareDetails()
                }
        }
    }
}

#Preview {
    ShareDetailView(viewModel: ShareDetailViewModel())
}
