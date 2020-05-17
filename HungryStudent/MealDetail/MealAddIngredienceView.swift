//
//  MealAddIngredienceView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View responsible for edit of list of ingrediences.

import SwiftUI

struct MealAddIngredienceView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    @Environment(\.presentationMode) var presentationMode
    
    var meal: Meal
    @State var selection: Set<Ingredience>
    
    var body: some View {
        NavigationView {
            List {
                // List of unselected ingrediences.
                ForEach(ingrediences){ ing in
                    if !self.selection.contains(ing) {
                        IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                    }
                }
                Text("Selected")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                // List of selected ingrediences.
                ForEach(ingrediences){ ing in
                    if self.selection.contains(ing) {
                        IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                    }
                }
            }.navigationBarItems(leading:
                // Cancels editing.
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                },trailing:
                // Saves changes.
                Button(action: {
                    AppDelegate.current.persistentContainer.viewContext.performAndWait {
                        self.meal.ingrediences = self.selection as NSSet
                        AppDelegate.current.saveContext()
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "plus.circle").resizable()
                        .frame(width: 32, height: 32, alignment: .center)
            })
                .navigationBarTitle(Text("Ingrediences"), displayMode: .inline)
        }
    }
}

struct MealAddIngredienceView_Previews: PreviewProvider {
    static var previews: some View {
        let a = Meal(context: debugGetContext)
        let b =  Set<Ingredience>()
        return MealAddIngredienceView(meal: a, selection: b).setCD() 
    }
}
