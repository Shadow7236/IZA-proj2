//
//  FilterMealsSelectIngView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for selecting ingrediences.

import SwiftUI


struct FilterMealsSelectIngView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    /// Set of selected ingrediences.
    @Binding var selection: Set<Ingredience>
    
    /// Searched prefix.
    @State var ingName = ""
    
    /// Filters ingrediences with prefix.
    var filteredIng: [Ingredience] {
        ingrediences.filter { $0.name?.lowercased().hasPrefix(ingName.lowercased()) == true }
    }
    
    var body: some View {
        VStack {
            SearchBar(placeholder: "Search ingredience", text: $ingName)
            Section {
                List {
                    /// List of unselected ingrediences.
                    ForEach(filteredIng){ ing in
                        if !self.selection.contains(ing) {
                            IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                        }
                    }
                    Text("Selected")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    /// List of selected ingrediences.
                    ForEach(filteredIng){ ing in
                        if self.selection.contains(ing) {
                            IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                        }
                    }
                }
            }
        }
    }
}

struct FilterMealsSelectIngView_Previews: PreviewProvider {
    static var previews: some View {
        return FilterMealsSelectIngView(selection: .constant(Set<Ingredience>())).setCD()
    }
}
