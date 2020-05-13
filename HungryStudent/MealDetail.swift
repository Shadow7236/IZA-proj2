//
//  MealDetail.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI
import CoreData

struct MealDetail: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject
    var meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    @State var selection = Set<Ingredience>()
    
    var body: some View {
        printdar()
        return NavigationView{
            Form{
                Section{
                    HStack{
                        Spacer()
                        AddImage()
                        Spacer()
                    }
                }
                Section(header: Text("Meal")) {
                    NameStars(meal: meal)
                }
                Section(header: Text("Receipt")) {
                    TextField("Receipt", text: self.meal.toBindable(keyPath: \.receipt))
                }
                Section(header: Text("Note")) {
                    TextField("Note", text: self.meal.toBindable(keyPath: \.note))
                }
            }
        }
    }
    
    func printdar(){
        print(self.meal.name ?? "None")
    }
}



struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(context: debugGetContext)
        meal.name = "None"
        meal.score = 3
        return MealDetail(meal: meal).setCD()
    }
}
