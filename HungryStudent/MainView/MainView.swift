//
//  MainView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  Shows and handles main purpose of appplication to find and show meals with help of ingrediences.

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var showAddMealSheet = false
    
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [.init(keyPath: \Meal.name, ascending: true)])
    var meals: FetchedResults<Meal>
    
    /// Set of seleted ingrediences
    @State var selIngred = Set<Ingredience>()
    
    var body: some View {
        VStack{
            /// Shows all found meals.
            FoundMealsView(selection: filterMeals()).animation(.easeIn)
            /// Handles selecting ingrediences.
            FilterMealsSelectIngView(selection: $selIngred).keyboardResponsive()
        }.navigationBarTitle("Found Meals")
    }
    
    
    /// Tests if meal has all selected ingrediences.
    /// - Parameter meal: meal to be tested
    /// - Returns: true if meal has all selected ingrediences
    func filterOneMeal(_ meal: Meal) -> Bool {
        let allIgs = Set(selIngred.compactMap { $0.id })
        guard !allIgs.isEmpty else { return true }
        let mealIng = Set(meal.ingrediences?.compactMap { ($0 as! Ingredience).id } ?? [])
        return allIgs.isSubset(of: mealIng)
    }
    
    /// Filters all meals.
    /// - Returns: set of meals with wanted ingrediences
    func filterMeals() -> Set<Meal> {
        let res = Set(meals.filter(filterOneMeal))
        return res
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().setCD()
    }
}
