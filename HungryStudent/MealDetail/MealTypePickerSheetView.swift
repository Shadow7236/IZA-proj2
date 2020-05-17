//
//  MealTypePickerSheetView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 13/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
// View for changing meal type.

import SwiftUI

struct MealTypePickerSheetView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment (\.presentationMode) var presentationMode
    
    @FetchRequest(entity: MealType.entity(),
                  sortDescriptors: [.init(keyPath: \MealType.name, ascending: true)])
    var mealTypes: FetchedResults<MealType>
    
    @State var meal: Meal
    @State var mealType: MealType
    @State var mealTypeIndex = 0
    
    // Count of meal types.
    var asd: Int {
        return mealTypes.count
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section(){
                    // Selects one meal type.
                    Picker(selection: $mealType, label: Text("")) {
                        ForEach(mealTypes) { mt in
                            Text(mt.name ?? "None")
                                .tag(mt)
                        }
                    }.pickerStyle(WheelPickerStyle())
                        .padding()
                }
            }
            .navigationBarTitle(Text("Set meal type"), displayMode: .inline)
            .navigationBarItems( leading:
                // Cancels changes.
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }, trailing:
                // Saves changes.
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
}

struct MealTypePickerSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let a = Meal(context: debugGetContext)
        a.name = "None"
        a.id = UUID()
        let b = MealType(context: debugGetContext)
        a.mealType = b
        return  MealTypePickerSheetView(meal: a, mealType: b).setCD() 
        
    }
}
