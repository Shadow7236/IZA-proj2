//
//  AddImageView.swift
//  HungryStudent
//
//  Taken from: https://www.hackingwithswift.com/books/ios-swiftui/building-our-basic-ui
//

import SwiftUI

struct AddImageView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @ObservedObject
    var meal: Meal
    
    @State private var filterIntensity = 0.5
    
    var body: some View {
        VStack {
            DataCoreImageView(meal: meal)
            .onTapGesture {
                self.showingImagePicker = true
            }
        }
        .padding([.horizontal, .bottom])
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let imageData = inputImage.pngData()
        AppDelegate.current.persistentContainer.viewContext.performAndWait {
            meal.image = imageData
            AppDelegate.current.saveContext()
        }
    }
    
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        let a = Meal(context: debugGetContext)
        return AddImageView(meal: a).setCD()
    }
}
