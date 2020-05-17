//
//  AppTabView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            NavigationView {
            MainView()
            }
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Find")
                        .font(.title)
            }.tag(0)
            NavigationView {
                MealsTypeList(filterType: nil)
            }.tabItem {
                Image(systemName: "text.justify")
                Text("Meals")
            }.tag(1)
            IngrediencesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Ingrediences")
            }.tag(2)
            MealsTypesView()
                .tabItem{
                    Image(systemName: "square.on.circle.fill").resizable().frame(width: 10)
                    Text("Meal Types")
            }.tag(3)
        }
    }
}



struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView().setCD()
    }
}
