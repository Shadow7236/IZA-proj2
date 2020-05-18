//
//  AddMealView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
// View for adding new meal.

import SwiftUI

struct AddMealView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    @FetchRequest(entity: MealType.entity(),
                  sortDescriptors: [.init(keyPath: \MealType.name, ascending: true)])
    var mealTypes: FetchedResults<MealType>
    
    enum ShowAlertType {
        case noName, noType
    }
    
    
    private let defaultMealType: MealType? = nil
    
    @State var mealType = MealType(context: AppDelegate.current.persistentContainer.viewContext)
    
    /// Variables for assigning new meal.
    @State var notes = ""
    @State var receipt = ""
    @State var mealName = ""
    @State var selection = Set<Ingredience>()
    
    /// For showing possible alert
    @State private var showAlert = false

    @State private var alertType: ShowAlertType = .noName
    
    @State private var selectedFrameworkIndex = 0
    
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                /// New meal name.
                Section(header: Text("Name")) {
                    TextField("Meal name", text: $mealName)
                }
                /// New meal receipt.
                Section(header: Text("Receipt")) {
                    TextField("Meal receipt", text: $receipt)
                }
                /// New meal notes.
                Section(header: Text("Notes")) {
                    TextField("Notes", text: $notes)
                }
                /// Shows picker for meal type.
                if !mealTypes.isEmpty {
                    Section(header: Text("Meal type")){
                        Picker(selection: $mealType, label: Text("")) {
                            ForEach(mealTypes) { mt in
                                self.getMealTypeName(mt: mt)
                            }
                        }.pickerStyle(WheelPickerStyle())
                            .padding()
                        
                    }
                }
                /// Handles selection of known ingrediences for meal
                Section(header: Text("Ingrediences")) {
                    List {
                        /// Unselected ingrediences.
                        ForEach(ingrediences){ ing in
                            if !self.selection.contains(ing) {
                                IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                            }
                        }
                        Text("Selected")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.top)
                        /// Selected ingrediences.
                        ForEach(ingrediences){ ing in
                            if self.selection.contains(ing) {
                                IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                            }
                        }
                    }
                }
                
            }.navigationBarTitle(Text("Add Meal"), displayMode: .inline)
                .navigationBarItems(leading:
                    /// Cancels view.
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    },trailing:
                    /// Saves new meal to database.
                    Button(action: {
                        if self.mealName.isEmpty {
                            self.showAlert = true
                            self.alertType = .noName
                        } else {
                            if self.mealType.id == nil {
                                self.showAlert = true
                                self.alertType = .noType
                            } else {
                                self.addMeal()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        Image(systemName: "plus.circle").resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                })
        }.alert(isPresented: $showAlert){
            if alertType == .noName {
            return Alert(title: Text("Error"), message: Text("Name field has to be filled"), dismissButton: .default(Text("Ok")))
            } else {
                return Alert(title: Text("Error"), message: Text("There is no type to be assigned"), dismissButton: .default(Text("Ok")))
            }
        }
            /// Assigns default value of meal type.
            .onAppear(){
                self.mealType = self.defaultMealType ?? self.mealTypes.last!
        }
    }
    
    
    /// Gets text view for meal type
    /// - Parameter mt: meal type
    /// - Returns: text view or empty view depending on existance of type
    func getMealTypeName(mt: MealType) -> AnyView {
        if let _ = mt.name {
            return AnyView(Text(mt.name!)
                .tag(mt))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    /// Creates and initializes new meal and saves it to database
    func addMeal() {
        if mealType.name != nil {
        _ = Meal(name: mealName, note: notes, receipt: receipt, ings: selection as NSSet, mealType: mealType)
        AppDelegate.current.saveContext()
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView().setCD()
    }
}

