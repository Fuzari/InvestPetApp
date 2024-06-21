//
//  SharesListView.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 20.06.2024.
//

import SwiftUI

struct SharesListView: View {
    @ObservedObject var viewModel: SharesListViewModel
    
    var body: some View {
        NavigationStack {
            switch viewModel.sharesList.count {
            case 0:
                ProgressView {
                    Text("Загрузка..")
                }
            default:
                List {
                    ForEach(viewModel.sharesList) { share in
                        ShareView(share: share)
                    }
                }
            }
        }
        .navigationTitle("Список инструментов Сбербанка")
        .onAppear(perform: {
            viewModel.loadShares()
        })
    }
}

struct ShareView: View {
    
    var share: ShareModel
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
            Text(share.name)
        }
    }
}

#Preview {
    SharesListView(viewModel: SharesListViewModel())
}
