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
        switch viewModel.sharesList.count {
        case 0:
            ProgressView {
                Text("Загрузка..")
            }
            .onAppear(perform: {
                viewModel.loadShares()
            })
        default:
            Text("Список инструментов Сбербанка")
            
            List {
                ForEach(viewModel.sharesList) { share in
                    ShareView(share: share)
                }
            }
        }
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
