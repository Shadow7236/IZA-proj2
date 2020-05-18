//
//  IngredienceSelectionRowView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for showing one ingredience in row with possibility to add it to set of ingrediences.

import SwiftUI

struct IngredienceSelectionRowView: View {
    
    @Binding var selection: Set<Ingredience>
    let ing: Ingredience
    
    var body: some View {
        HStack {
            /// Toggles selection state of current ingredience.
            Button(action: {
                if self.selection.contains(self.ing) {
                    self.selection = self.selection.filter { $0 != self.ing }
                } else {
                    self.selection.insert(self.ing)
                }
            }) {
                if selection.contains(ing) {
                    Image(systemName: "checkmark.square")
                } else {
                    Image(systemName: "square")
                }
                
            }
            Spacer()
            /// Shows name of ingredience.
            Text(ing.name ?? "None" )
            } .padding()
        
        
    }
}

struct IngredienceSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        let ingred = Ingredience(context: debugGetContext)
        let sel = Set<Ingredience>()
        return IngredienceSelectionRowView(selection: .constant(sel), ing: ingred).setCD()
    }
}
