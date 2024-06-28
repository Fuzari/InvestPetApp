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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                viewModel.loadShareDetails()
            }
    }
}

#Preview {
    ShareDetailView(viewModel: ShareDetailViewModel())
}
