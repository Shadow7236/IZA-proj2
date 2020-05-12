//
//  FavouriteButtonView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct FavouriteButtonView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var meal: Meal
    
    var body: some View {
        Image(systemName: isFav)
            .resizable().scaledToFit()
            .frame(width: 40)
            .foregroundColor(.red)
            .onTapGesture {
                self.managedObjectContext.performAndWait {
                    self.meal.isFavourite.toggle()
                    AppDelegate.current.saveContext()
                }
                
        }
    }
    
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
