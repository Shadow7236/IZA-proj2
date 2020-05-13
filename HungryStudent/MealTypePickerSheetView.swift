//
//  MealTypePickerSheetView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 13/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct MealTypePickerSheetView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment (\.presentationMode) var presentationMode
    
    @FetchRequest(entity: MealType.entity(),
                  sortDescriptors: [.init(keyPath: \MealType.name, ascending: true)])
    var mealTypes: FetchedResults<MealType>
    
    @State var meal: Meal
    @State var mealType: MealType? = nil
    
    var body: some View {
        Form {
            Section(){
                Picker(selection: $mealType, label: Text("")) {
                    ForEach(mealTypes) { mt in
                        Text(mt.name ?? "None")
                            .tag(mt)
                    }
                }.pickerStyle(WheelPickerStyle())
                    .padding()
            }
        }
        .navigationBarTitle(Text("Set new meal type"), displayMode: .inline)
        .navigationBarItems( leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            }, trailing:
            Button(action: {
                AppDelegate.current.persistentContainer.viewContext.performAndWait {
                    self.meal.mealType = self.mealType
                    AppDelegate.current.saveContext()
                }
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "plus.circle").resizable()
                    .frame(width: 32, height: 32, alignment: .center)
        })
    }
}

struct MealTypePickerSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let a = Meal(context: debugGetContext)
        a.name = "None"
        a.id = UUID()
        let b = MealType(context: debugGetContext)
        a.mealType = b
        return NavigationView { MealTypePickerSheetView(meal: a, mealType: b).setCD() }
     
    }
}
