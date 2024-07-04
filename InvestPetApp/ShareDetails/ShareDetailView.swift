//
//  ShareDetailView.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 27.06.2024.
//

import SwiftUI

struct ShareDetailView: View {
    
    @ObservedObject var viewModel: ShareDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            switch viewModel.shareDetailModel {
            case .data(model: let lastPrice):
                Text(lastPrice.price.units)
                Text(lastPrice.time)
            case .empty(model: let emptyModel):
                Text(emptyModel.title)
                    .task {
                        viewModel.loadShareDetails()
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                    viewModel.cancelConnection()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                }
            }
        }
    }
}

#Preview {
    ShareDetailView(viewModel: ShareDetailViewModel())
}
