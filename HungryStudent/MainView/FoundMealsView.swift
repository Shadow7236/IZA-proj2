//
//  FoundMealsView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct FoundMealsView: View {
    let selection: Set<Meal>
    
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
            if self.selection.isEmpty {
                Text("Not found").font(.title)
            } else {
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
