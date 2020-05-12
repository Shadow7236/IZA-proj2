//
//  MealsTypesView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct MealsTypesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: MealType.entity(),
                  sortDescriptors: [.init(keyPath: \MealType.name, ascending: true)])
    var mealTypes: FetchedResults<MealType>
    
    var filteredTypes: [MealType] {
        mealTypes.filter { $0.name?.lowercased().hasPrefix(name.lowercased()) == true }
    }
    
    @State var showAddMealTypeSheet = false
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(placeholder: "Enter meal name", text: $name)
                ForEach(filteredTypes) { order in
                    Text(order.name ?? "None")
//                    NavigationLink(destination: MealsTypeList(filterType: order)) {
//                        Text(order.name ?? "None")
//                    }
                }
            }.navigationBarItems(trailing:
                Button(action: {
                    self.showAddMealTypeSheet = true
                }) {
                    Image(systemName: "plus.circle").resizable()
                        .frame(width: 32, height: 32, alignment: .center)
                }
            )
                .navigationBarTitle("MealTypes")
        }.sheet(isPresented: $showAddMealTypeSheet) {
            AddMealTypeView()
        }
    }
    
    struct MealsTypesView_Previews: PreviewProvider {
        static var previews: some View {
            MealsTypesView().setCD()
        }
    }
}
