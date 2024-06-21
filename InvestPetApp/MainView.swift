//
//  ContentView.swift
//  InvestPetApp
//
//  Created by Andrei Iakovlev on 19.06.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            Text("Сервис для получения последних сделок по инструментам")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
            
            NavigationLink("Начать работу") {
                SharesListView(viewModel: SharesListViewModel())
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
