//
//  AddMealView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct AddMealView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    @FetchRequest(entity: MealType.entity(),
                  sortDescriptors: [.init(keyPath: \MealType.name, ascending: true)])
    var mealTypes: FetchedResults<MealType>
    
    init(defaultMealType: MealType? = nil) {
        self.defaultMealType = defaultMealType
    }
    
    private let defaultMealType: MealType?
    
    @State var mealType = MealType()
    
    @State var notes = ""
    @State var receipt = ""
    @State var mealName = ""
    @State var selection = Set<Ingredience>()
    
    @State private var selectedFrameworkIndex = 0
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                HStack{
                    Spacer()
                    AddImage()
                    Spacer()
                }
                Section(header: Text("Name")) {
                    TextField("Meal name", text: $mealName)
                }
                Section(header: Text("Receipt")) {
                    TextField("Meal receipt", text: $receipt)
                }
                Section(header: Text("Notes")) {
                    TextField("Notes", text: $notes)
                }
                if !mealTypes.isEmpty {
                    Section(header: Text("Meal type")){
                        Picker(selection: $mealType, label: Text("")) {
                            ForEach(mealTypes) { mt in
                                Text(mt.name ?? "None")
                                    .tag(mt)
                            }
                        }.pickerStyle(WheelPickerStyle())
                            .padding()
                        
                    }
                }
                Section(header: Text("Ingrediences")) {
                    List {
                        ForEach(ingrediences){ ing in
                            if !self.selection.contains(ing) {
                                IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                            }
                        }
                        Text("Selected")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        ForEach(ingrediences){ ing in
                            if self.selection.contains(ing) {
                                IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                            }
                        }
                    }
                }
                
            }.navigationBarTitle(Text("Add Meal"), displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    },trailing:
                    Button(action: {
                        self.addMeal()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "plus.circle").resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                })
        }
        .onAppear(){
            self.mealType = self.defaultMealType ?? self.mealTypes.first!
        }
    }
    
    func addMeal() {
        _ = Meal(name: mealName, note: notes, receipt: receipt, ings: selection as NSSet, mealType: mealType)
        AppDelegate.current.saveContext()
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView().setCD()
    }
}

