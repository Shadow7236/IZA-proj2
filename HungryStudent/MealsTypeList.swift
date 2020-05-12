//
//  MealsTypeList.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct MealsTypeList: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var showAddMealSheet = false
    
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [.init(keyPath: \Meal.name, ascending: true)])
    var meals: FetchedResults<Meal>
    
    var filterType: String
    
    var filteredMeals: [Meal] {
        meals.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true && $0.name?.lowercased() == filterType.lowercased()}
    }
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(placeholder: "Enter meal name", text: $name)
                ForEach(filteredMeals) { order in
                    MealRowView(meal: order)
                    NavigationLink(destination: MealDetail()) {
                        Text(order.name ?? "None")
                    }
                }
            }.navigationBarItems(trailing:
                Button(action: {
                    self.showAddMealSheet = true
                }) {
                    Image(systemName: "plus.circle").resizable()
                        .frame(width: 32, height: 32, alignment: .center)
                }
            )
                .navigationBarTitle("Meals")
        }.sheet(isPresented: $showAddMealSheet) {
            AddMealView()
        }
    }
}

struct MealsTypeList_Previews: PreviewProvider {
    static var previews: some View {
        let ft = ""
        return MealsTypeList(filterType: ft).setCD()
    }
}
