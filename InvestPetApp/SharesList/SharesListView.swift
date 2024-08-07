//
//  SharesListView.swift
//  InvestPetApp
//
//  Created by Andrey Yakovlev on 20.06.2024.
//

import SwiftUI

struct SharesListView: View {
    @ObservedObject var viewModel: SharesListViewModel
    
    private let token: String
    
    init(token: String) {
        self.token = token
        self.viewModel = SharesListViewModel(token: token)
    }
    
    var body: some View {
        switch viewModel.instrumentsList.count {
        case 0:
            ProgressView {
                Text("Загрузка..")
            }
            .task {
                viewModel.loadShares()
            }
        default:
            Text("Список инструментов Сбербанка")
            
            List(viewModel.instrumentsList, id: \.self) { instrument in
                NavigationLink {
                    ShareDetailView(token: token, instrument: instrument)
                } label: {
                    InstrumentView(instrument: instrument)
                }
            }
        }
    }
}

struct InstrumentView: View {
    
    var instrument: InstrumentModel
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
            Text(instrument.ticker)
            Text(instrument.name)
                .lineLimit(1)
        }
    }
}

#Preview {
    SharesListView(token: "token")
}
