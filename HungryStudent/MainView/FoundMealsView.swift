//
//  FoundMealsView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for shoving all filtered meals in main view.

import SwiftUI

struct FoundMealsView: View {
    // Selection of meals.
    let selection: Set<Meal>
    
    /// Sorted selection of meals.
    var sortedSelection: [Meal] {
        selection.sorted { l, r in
            guard let a = l.name, let b = r.name else {
                return false
            }
            return a < b
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            /// None meal found.
            if self.selection.isEmpty {
                Text("None found").font(.title)
            } else {
                /// Shows found meal image and name.
                HStack(alignment: .top) {
                    ForEach(sortedSelection) { meal in
                        FoundMealImageView(meal: meal)
                    }
                }
            }
        }.padding()
    }

}

struct FoundMealsView_Previews: PreviewProvider {
    static var previews: some View {
        return FoundMealsView(selection: []).setCD()
    }
}
