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
        //        print("here i am")
        let a = meals.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true }
        let b = meals.filter { $0.mealType?.name?.lowercased() == filterType.lowercased() }
        let r = meals.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true && $0.mealType?.name?.lowercased() == filterType.lowercased()}
        //        print("all count: \(meals.count)")
        //        print("a, filtered count \(a.count)")
        //        print("b, filtered count \(b.count)")
        //        print("prefix: '\(name.lowercased())', filtered count \(r.count)")
        //        print("ft:", filterType)
        //        meals.forEach { x in
        //            print(x.name ?? "unknown", x.mealType, x.mealType?.name)
        //        }
        return r
    }
    
    @State private var name = ""
    
    var body: some View {
        List {
            SearchBar(placeholder: "Enter meal name", text: $name)
            ForEach(filteredMeals) { order in
                NavigationLink(destination: MealDetail(meal: order)) {
                    MealRowView(meal: order)
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
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
}

struct MealsTypeList_Previews: PreviewProvider {
    static var previews: some View {
        let ft = "None"
        return NavigationView { MealsTypeList(filterType: ft).setCD() }

    }
}
