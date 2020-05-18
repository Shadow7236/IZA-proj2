//
//  FavouriteButtonView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
// View showing favourite button of meal.

import SwiftUI

struct FavouriteButtonView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject
    var meal: Meal
    
    var body: some View {
        Image(systemName: isFav)
            .resizable().scaledToFit()
            .frame(width: 40)
            .foregroundColor(.red)
            /// On tap it toggles value and saves it to database
            .onTapGesture {
                self.managedObjectContext.performAndWait {
                    self.meal.isFavourite.toggle()
                    AppDelegate.current.saveContext()
                }
        }
    }
    
    /// Variable for choosing image depending on favourite attribute.
    var isFav: String{
        if meal.isFavourite {
            return  "heart.fill"
        } else {
            return "heart"
        }
    }
}

struct FavouriteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(context: debugGetContext)
        meal.isFavourite = false
        return FavouriteButtonView(meal: meal)
            .previewLayout(.sizeThatFits)
    }
}
