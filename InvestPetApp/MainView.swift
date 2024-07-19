//
//  ContentView.swift
//  InvestPetApp
//
//  Created by Andrei Iakovlev on 19.06.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var inputText: String = ""
    
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Сервис для получения последних сделок по инструментам")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
            
            TextField("Токен доступа к API", text: $inputText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .font(.system(.title3))
                .padding([.horizontal, .bottom], 30)
            
            
            NavigationLink("Начать работу") {
                SharesListView(token: inputText)
            }
            
            Spacer()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
