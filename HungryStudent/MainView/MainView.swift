//
//  MainView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var showAddMealSheet = false
    
    @FetchRequest(entity: Meal.entity(),
                  sortDescriptors: [.init(keyPath: \Meal.name, ascending: true)])
    var meals: FetchedResults<Meal>
    

    
    @State var selIngred = Set<Ingredience>()
    
    var body: some View {
        VStack{
            FoundMealsView(selection: filterMeals()).animation(.easeIn)
            FilterMealsView(selection: $selIngred)
            
        }.navigationBarTitle("Found Meals")
    }
    
    func filterOneMeal(_ meal: Meal) -> Bool {
        let allIgs = Set(selIngred.compactMap { $0.id })
        guard !allIgs.isEmpty else { return true }
        let mealIng = Set(meal.ingrediences?.compactMap { ($0 as! Ingredience).id } ?? [])

        return allIgs.isSubset(of: mealIng)
    }
    
    
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
