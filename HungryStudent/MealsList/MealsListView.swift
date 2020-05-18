//
//  MealsListView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for listing all meals. Can show also show meals with searched prefix.


import SwiftUI

struct MealsListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    /// For showing new add view.
    @State var showAddMealSheet = false
    
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [.init(keyPath: \Meal.name, ascending: true)])
    var meals: FetchedResults<Meal>
    
    /// For  filtering only meals with certain meal type.
    var filterType: String?  = nil
    
    /// Filters meals by searched prefix and then sorts them by isFavourite attribute.
    var filteredMeals: [Meal] {
        let r: [Meal]
        if let a = filterType {
            r = meals.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true && $0.mealType?.name?.lowercased() == a.lowercased()}
        } else {
            r = meals.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true }
        }
        return r
    }
    
    /// For searched prefix.
    @State private var name = ""
    
    var body: some View {
        List {
            SearchBar(placeholder: "Enter meal name", text: $name)
            /// Shows only filtered meals.
            ForEach(filteredMeals) { order in
                NavigationLink(destination: MealDetail(meal: order)) {
                    MealRowView(meal: order)
                }
            }.onDelete(perform: removeMeal)
        }.sheet(isPresented: $showAddMealSheet) {
            AddMealView()
                .environment(\.managedObjectContext, self.managedObjectContext)
        }.navigationBarItems(trailing:
            /// Allows showing view for adding new meal.
            Button(action: {
                self.showAddMealSheet = true
            }) {
                Image(systemName: "plus.circle").resizable()
                    .frame(width: 32, height: 32, alignment: .center)
            }
        )
        .navigationBarTitle("Meals")
    }
    
    /// Removes meal from database.
    /// - Parameter offsets: inex to meal database
    func removeMeal(at offsets: IndexSet) {
        for index in offsets {
            let delMeal = meals[index]
            managedObjectContext.delete(delMeal)
            AppDelegate.current.saveContext()
        }
    }
}

struct MealsListView_Previews: PreviewProvider {
    static var previews: some View {
        let ft = "None"
        return NavigationView { MealsListView(filterType: ft).setCD() }

    }
}
