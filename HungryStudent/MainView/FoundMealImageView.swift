//
//  FoundMealImageView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View showing found meal image and name as link to its detailed view.

import SwiftUI

struct FoundMealImageView: View {
    @Environment(\.colorScheme)
    var scheme
    
    @ObservedObject
    var meal: Meal
    
    var body: some View {
        NavigationLink(destination: MealDetail(meal: meal)) {
            VStack {
                /// Shows image of meal or add image if none is assigned to meal.
                DataCoreImageView(meal: meal, baseImgWidth: 70)
                /// Shows meal name. If name is too long it can break to new line.
                Text(meal.name ?? "None").font(.subheadline)
                .frame(idealWidth: 70, maxWidth: nil)
                    .lineLimit(nil)
            }
            .foregroundColor(scheme == .dark ? .white : .black)
        }
    }
}

struct FoundMealImageView_Previews: PreviewProvider {
    static var previews: some View {
        let a = Meal(context: debugGetContext)
        return NavigationView { FoundMealImageView(meal: a).setCD() }.environment(\.colorScheme, .light)
    }
}
