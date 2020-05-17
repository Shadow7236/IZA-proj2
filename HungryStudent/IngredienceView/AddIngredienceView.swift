//
//  AddIngredienceView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 16/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct AddIngredienceView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment (\.presentationMode) var presentationMode
    
    @State var name = ""
    
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            List {
                TextField("Enter name of new ingredience", text: $name)
            }
            .navigationBarTitle(Text("Add ingredience"), displayMode: .inline)
            .navigationBarItems( leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }, trailing:
                Button(action: {
                    if self.name.isEmpty {
                        self.showAlert = true;
                    } else {
                        let a = Ingredience(context: AppDelegate.current.persistentContainer.viewContext)
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

struct AddIngredienceView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredienceView()
    }
}
