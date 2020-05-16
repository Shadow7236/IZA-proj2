//
//  ContentView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //    @Environment(\.managedObjectContext)
    //    private var db
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: MealType.entity(),
                  sortDescriptors: [.init(keyPath: \MealType.name, ascending: true)])
    var mealTypes: FetchedResults<MealType>
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    
    var body: some View {
        initMealTypes()
        initIngrediences()
        return AppTabView()
    }
    
    func initMealTypes() {
        if mealTypes.isEmpty {
            let a = MealType(context: debugGetContext)
            a.name = "None"
            a.id = UUID()
            AppDelegate.current.saveContext()
        }
    }
    
    func initIngrediences() {
        if ingrediences.isEmpty {
            let a = Ingredience(context: debugGetContext)
            a.name = "None"
            a.id = UUID()
            AppDelegate.current.saveContext()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        wrapToContext(ContentView())
    }
}
