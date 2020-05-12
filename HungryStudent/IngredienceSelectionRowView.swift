//
//  IngredienceSelectionRowView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct IngredienceSelectionRowView: View {
    
    @Binding var selection: Set<Ingredience>
    let ing: Ingredience
    
    var body: some View {
        HStack {
            Button(action: {
//                self.onTap(self.ingId)
                if self.selection.contains(self.ing) {
                    self.selection = self.selection.filter { $0 != self.ing }
                } else {
                    self.selection.insert(self.ing)
                }
            }) {
                if selection.contains(ing) {
                    Image(systemName: "square.fill")
                } else {
                    Image(systemName: "square")
                }
                
            }
            Spacer()
            Text(ing.name ?? "None" )
        }
        
        
    }
}

struct IngredienceSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        let ingred = Ingredience()
        let sel = Set<Ingredience>()
        return IngredienceSelectionRowView(selection: .constant(sel), ing: ingred)
    }
}
