//
//  IngrediencesView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for showing all ingrediences, adding new ingrediences and removeing ingrediences.

import SwiftUI

struct IngrediencesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    @State var showAddIngredienceView = false
    
    @State var name = ""
    
    /// Filters ingrediences by what is searched.
    var filteredIngrediences: [Ingredience] {
           ingrediences.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true }
    }
    
    var body: some View {
        NavigationView {
            List{
                SearchBar(placeholder: "Enter ingredience name", text: $name)
                /// List of all ingrediences with searching prefix.
                ForEach(filteredIngrediences){ ing in
                    Text(ing.name ?? "None")
                }.onDelete(perform: removeIng)
            }.keyboardResponsive().sheet(isPresented: $showAddIngredienceView) {
                AddIngredienceView()
                    .environment(\.managedObjectContext, self.managedObjectContext)
            }
            .navigationBarTitle("Ingrediences")
            .navigationBarItems(trailing: Button(action: {
                self.showAddIngredienceView = true
            }) {
                Image(systemName: "plus.circle").resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                }
            )
        }
    }
    
    /// Removes ingredience from database.
    /// - Parameter offsets: index to ingredience database.
    func removeIng(at offsets: IndexSet) {
        for index in offsets {
            let delIng = ingrediences[index]
            managedObjectContext.delete(delIng)
            AppDelegate.current.saveContext()
        }
    }
}

struct IngrediencesView_Previews: PreviewProvider {
    static var previews: some View {
        IngrediencesView().setCD()
    }
}
