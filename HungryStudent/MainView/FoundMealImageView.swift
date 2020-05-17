//
//  FoundMealImageView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct FoundMealImageView: View {
    
    @ObservedObject
    var meal: Meal
    
    var body: some View {
        NavigationLink(destination: MealDetail(meal: meal)) {
            VStack {
                DataCoreImageView(meal: meal, baseImgWidth: 70)
                Text(meal.name ?? "None").font(.subheadline)
                .frame(idealWidth: 70, maxWidth: nil)
                    .lineLimit(nil)
            }
            .foregroundColor(.black)
        }
    }
}

struct FoundMealImageView_Previews: PreviewProvider {
    static var previews: some View {
        let a = Meal(context: debugGetContext)
        return NavigationView { FoundMealImageView(meal: a).setCD() }
    }
}
