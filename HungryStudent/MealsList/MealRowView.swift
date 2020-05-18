//
//  MealRowView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for showing one row with meal information.

import SwiftUI

struct MealRowView: View {
    
    @ObservedObject
    var meal: Meal
    
    var body: some View {
        HStack{
            /// Shows image for meal
            DataCoreImageView(meal: meal, baseImgWidth: 50)
            /// Shows meal name.
            Text("\(meal.name ?? "Unknown")")
                .font(.headline)
                .padding()
            Spacer()
            /// Shows favourite button
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
