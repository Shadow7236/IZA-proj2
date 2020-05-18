//
//  MealDetail.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  Shows detailed known information about meal.

import SwiftUI
import CoreData

struct MealDetail: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Ingredience.entity(),
                  sortDescriptors: [.init(keyPath: \Ingredience.name, ascending: true)])
    var ingrediences: FetchedResults<Ingredience>
    
    /// Source of new image.
    @State private var addImageFrom: UIImagePickerController.SourceType = .photoLibrary
    
    /// Enumeration for deciding which sheet to show.
    enum ShowSheetType {
        case addIngredience, addImage
    }
    
    /// Holds information if any sheet should be shown.
    @State var showSheet = false
    
    /// Which type of sheet should be shown.
    @State private var showSheetType: ShowSheetType = .addImage
    
    /// Variable for storing image.
    @State private var inputImage: UIImage?
    
    @ObservedObject
    var meal: Meal
    
    /// Set of meal ingrediences.
    var selection: Set<Ingredience> {
        if let a = meal.ingrediences {
            return Set<Ingredience>(_immutableCocoaSet: a)
        } else {
            return Set<Ingredience>()
        }
    }
    
    var body: some View {
        Form {
            /// Handles image of meal.
            Section{
                HStack{
                    Spacer()
                    DataCoreImageView(meal: meal)
                    Spacer()
                }
            }
            /// Handles name, type of meal and if it is favoured.
            Section(header: Text("Meal")) {
                NameTypeFavouriteView(meal: meal, name:  meal.name ?? "No name")
            }
            /// Shows receipt.
            Section(header: Text("Receipt")) {
                TextField("Receipt", text: self.meal.toBindable(keyPath: \.receipt))
            }
            /// Shows notes.
            Section(header: Text("Note")) {
                TextField("Note", text: self.meal.toBindable(keyPath: \.note))
            }
            /// Shows list of ingrediences for meal.
            Section(header: HStack{
                Text("Ingrediences")
                Spacer()
                /// Handles showing view for editing ingrediences
                Button(action: {
                    self.showSheet = true
                    self.showSheetType = .addIngredience
                }) {
                    Text("Edit")
                }
            }){
                List {
                    /// List of ingrediences.
                    ForEach(ingrediences.filter({selection.contains($0) })){ ing in
                        Text(ing.name ?? "None")
                    }
                }
            }
        }
        .navigationBarItems(trailing: HStack {
            /// Button for adding image from library.
            Button(action: {
                self.addImageFrom = .photoLibrary
                self.showSheetType = ShowSheetType.addImage
                self.showSheet = true
            }){
                Image(systemName: "photo").resizable().frame(width: 20, height: 20)
            }
            /// Button for adding image from camera.
            Button(action: {
                self.addImageFrom = .camera
                self.showSheetType = ShowSheetType.addImage
                self.showSheet = true
            }){
                Image(systemName: "camera.fill").resizable().frame(width: 20, height: 20)
            }
        }).sheet(isPresented: $showSheet, onDismiss: loadImage) {
            /// Decides which sheet will be showed.
                if self.showSheetType == ShowSheetType.addImage {
                    ImagePicker(image: self.$inputImage, sourceType: self.addImageFrom)
                } else {
                    MealAddIngredienceView(meal: self.meal, selection: self.selection)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                }
        }
    }
    
    /// Saves image into database.
    func loadImage() {
        if self.showSheetType == .addImage {
            guard let inputImage = inputImage else { return }
            let imageData = inputImage.pngData()
            AppDelegate.current.persistentContainer.viewContext.performAndWait {
                meal.image = imageData
                AppDelegate.current.saveContext()
            }
        }
    }
}



struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(context: debugGetContext)
        meal.name = "None"
        meal.score = 3
        return NavigationView { MealDetail(meal: meal).setCD() }
    }
}
