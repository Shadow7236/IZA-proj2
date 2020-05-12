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
        
    @State var notes = ""
    @State var receipt = ""
    @State var mealName = ""
    @State var selection = Set<Ingredience>()
    
    var frameworks = ["UIKit", "Core Data", "CloudKit", "SwiftUI"]
    @State private var selectedFrameworkIndex = 0
    
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
                Section {
                    List {
                        ForEach(ingrediences){ ing in
                            IngredienceSelectionRowView(selection: self.$selection, ing: ing)
                        }
                    }
                }
                Button(action: {
                    print("Save the order!")
                }) {
                    Text("Add Meal")
                }
                
                
            }.navigationBarTitle("Add Meal")
        }
    }
}

struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealView().setCD()
    }
}
