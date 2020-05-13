//
//  NameStars.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct NameStars: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    public struct CustomTextFieldStyle : TextFieldStyle {
        public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .font(.title) 
        }
    }
    
    @State var showPickerSheet = false
    
    var meal: Meal
    
    var body: some View {
        HStack {
            VStack {
                HStack{
                    TextField("Name", text: self.meal.toBindable(keyPath: \.name))
                        .textFieldStyle(CustomTextFieldStyle())
                    Spacer()
                }
                HStack{
                    Text(meal.mealType?.name ?? "None")
                        .font(.subheadline)
                        .onTapGesture {
                            self.showPickerSheet = true
                    }
                    Spacer()
                }
            }
            Spacer()
            FavouriteButtonView(meal: meal)
        }.sheet(isPresented: $showPickerSheet) {
            MealTypePickerSheetView(meal:self.meal, mealType: self.meal.mealType ?? nil)
                .environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
}

struct NameStars_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(context: debugGetContext)
        meal.isFavourite = false
        meal.name = "None"
        return NameStars(meal: meal)
    }
}
