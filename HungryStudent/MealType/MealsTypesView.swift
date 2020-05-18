//
//  MealsTypesView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
// Shows all types of meals and handles adding new and removeing.

import SwiftUI

struct MealsTypesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: MealType.entity(),
                  sortDescriptors: [.init(keyPath: \MealType.name, ascending: true)])
    var mealTypes: FetchedResults<MealType>
    
    var filteredTypes: [MealType] {
        /// Filters meal types by what is searched.
        mealTypes.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true }
    }
    
    @State var showAddMealTypeSheet = false
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            List { 
                SearchBar(placeholder: "Enter meal name", text: $name)
                /// List of all meal types with searched prefix.
                ForEach(filteredTypes) { order in
                        Text(order.name ?? "None")
                }.onDelete(perform: removeMealType)
            }.keyboardResponsive().navigationBarItems(trailing:
                /// Shows adding view.
                Button(action: {
                    self.showAddMealTypeSheet = true
                }) {
                    Image(systemName: "plus.circle").resizable()
                        .frame(width: 32, height: 32, alignment: .center)
                }
            )
                .navigationBarTitle("MealTypes")
        }.sheet(isPresented: $showAddMealTypeSheet) {
            AddMealTypeView()
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
    
    /// Removes meal type from database
    
    
    /// Removes meal type from database on idex.
    /// - Parameter offsets: index
    func removeMealType(at offsets: IndexSet) {
        for index in offsets {
            let delMealType = mealTypes[index]
            managedObjectContext.delete(delMealType)
            AppDelegate.current.saveContext()
        }
    }
}

struct MealsTypesView_Previews: PreviewProvider {
    static var previews: some View {
        MealsTypesView().setCD()
    }
}

