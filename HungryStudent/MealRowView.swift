//
//  MealRowView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct MealRowView: View {
    var meal: Meal
    
    var body: some View {
        HStack{
            Text("image")
            Text("\(meal.name ?? "Unknown")")
                .font(.headline)
            Spacer()
            FavouriteButtonView(meal: meal)
        }
        .padding()
    }
}

struct MealRowView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(context: debugGetContext)
        meal.name = "NAME OF MEAL"
        return MealRowView(meal: meal)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
