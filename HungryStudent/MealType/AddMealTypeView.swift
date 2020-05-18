//
//  AddMealTypeView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for adding new meal type.

import SwiftUI

struct AddMealTypeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment (\.presentationMode) var presentationMode
    
    @State var name = ""
    
    /// Handles if alert should be shown.
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            /// Textfield for new name.
            List {
                TextField("Enter name of new meal type", text: $name)
            }
            .navigationBarTitle(Text("Add meal type"), displayMode: .inline)
            .navigationBarItems( leading:
                /// Cancels adding view.
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }, trailing:
                /// Saves new meal type or if meal type name was not defined shows alert.
                Button(action: {
                    if self.name == "" {
                        self.showAlert = true
                    } else {
                        let a = MealType(context: AppDelegate.current.persistentContainer.viewContext)
                        a.name = self.name
                        a.id = UUID()
                        AppDelegate.current.saveContext()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Image(systemName: "plus.circle").resizable()
                        .frame(width: 32, height: 32, alignment: .center)
            })
        }.alert(isPresented: $showAlert){
            Alert(title: Text("Error"), message: Text("Name field has to be filled"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct AddMealTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AddMealTypeView()
    }
}
