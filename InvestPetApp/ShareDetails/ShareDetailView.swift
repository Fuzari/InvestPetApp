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
            case .data(model: let model):
                Text(model.title)
                Text(model.subtitle)
            case .empty(model: let emptyModel):
                Text(emptyModel.title)
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
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    ShareDetailView(
        viewModel: ShareDetailViewModel(
            instrument: InstrumentModel(),
            shareDetailsService: ShareDetailsService(
                shareId: ""
            )
        )
    )
}
