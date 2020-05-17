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
    
    var filterType: String?  = nil
    
    var filteredMeals: [Meal] {
        if let a = filterType {
            let r = meals.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true && $0.mealType?.name?.lowercased() == a.lowercased()}
            return r
        } else {
            let r = meals.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true }
            return r
        }
    }
    
    @State private var name = ""
    
    var body: some View {
        List {
            SearchBar(placeholder: "Enter meal name", text: $name)
            ForEach(filteredMeals) { order in
                NavigationLink(destination: MealDetail(meal: order)) {
                    MealRowView(meal: order)
                }
            }.onDelete(perform: removeMeal)
        }.sheet(isPresented: $showAddMealSheet) {
            AddMealView()
                .environment(\.managedObjectContext, self.managedObjectContext)
        }.navigationBarItems(trailing:
            Button(action: {
                self.showAddMealSheet = true
            }) {
                Image(systemName: "plus.circle").resizable()
                    .frame(width: 32, height: 32, alignment: .center)
            }
        )
        .navigationBarTitle("Meals")
    }
    
    func removeMeal(at offsets: IndexSet) {
        for index in offsets {
            let delMeal = meals[index]
            managedObjectContext.delete(delMeal)
            AppDelegate.current.saveContext()
        }
    }
}

struct MealsTypeList_Previews: PreviewProvider {
    static var previews: some View {
        let ft = "None"
        return NavigationView { MealsTypeList(filterType: ft).setCD() }

    }
}
