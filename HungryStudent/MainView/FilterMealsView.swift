//
//  FilterMealsView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct FilterMealsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    @Binding var selection: Set<Ingredience>
    
    @State var ingName = ""
    
    var filteredIng: [Ingredience] {
        ingrediences.filter { $0.name?.lowercased().hasPrefix(ingName.lowercased()) == true }
    }
    
    var body: some View {
        VStack {
            SearchBar(placeholder: "Search ingredience", text: $ingName)
            Section {
                List {
                    ForEach(ingrediences){ ing in
                        if !self.selection.contains(ing) {
                            IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                        }
                    }
                    Text("Selected")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.top)
                    ForEach(ingrediences){ ing in
                        if self.selection.contains(ing) {
                            IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                        }
                    }
                }
            }
        }
    }
}

struct FilterMealsView_Previews: PreviewProvider {
    static var previews: some View {
        return FilterMealsView(selection: .constant(Set<Ingredience>())).setCD()
    }
}
