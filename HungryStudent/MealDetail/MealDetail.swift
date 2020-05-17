//
//  MealDetail.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI
import CoreData

struct MealDetail: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    @State var img: Image?
    
    @State var showAddIngredienceView = false
    
    @ObservedObject
    var meal: Meal
    
    var selection: Set<Ingredience> {
        if let a = meal.ingrediences {
            return Set<Ingredience>(_immutableCocoaSet: a)
        } else {
            return Set<Ingredience>()
        }
        
    }
    
    var body: some View {
        Form {
            Section{
                HStack{
                    Spacer()
                    AddImageView(meal: meal)
                    Spacer()
                }
            }
            Section(header: Text("Meal")) {
                NameStars(meal: meal, name:  meal.name ?? "No name")
            }
            Section(header: Text("Receipt")) {
                TextField("Receipt", text: self.meal.toBindable(keyPath: \.receipt))
            }
            Section(header: Text("Note")) {
                TextField("Note", text: self.meal.toBindable(keyPath: \.note))
            }
            Section(header: HStack{
                Text("Ingrediences")
                Spacer()
                Button(action: {
                    self.showAddIngredienceView = true
                    }) {
                        Text("Edit")
                    }
            }){
                List {
                    ForEach(ingrediences.filter({selection.contains($0) })){ ing in
                        Text(ing.name ?? "None")
                    }
                }
            }
        }.sheet(isPresented: $showAddIngredienceView) {
            MealAddIngredienceView(meal: self.meal, selection: self.selection)
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
}



struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(context: debugGetContext)
        meal.name = "None"
        meal.score = 3
        return MealDetail(meal: meal).setCD()
    }
}
