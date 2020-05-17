//
//  DataCoreImageView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 15/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for showing image for certain meal. If meal doesn't have assigned any image, AddImage icon is shown

import SwiftUI

struct DataCoreImageView: View {
    
    @ObservedObject
    var meal: Meal
    
    var baseImgWidth: CGFloat = 200
    
    var body: some View {
        getImage()
    }
    
    
    
    // Returns meal image if it is assigned otherwise AddImage icon is returned.
    func getImage() -> some View {
        guard let image = getImageFromCD() else {
            return AnyView(AddImage(baseWidth: baseImgWidth))
        }
        let img = image
            .scaledToFit()
        return AnyView(img)
    }
    
    // Returns formated image of meal from database if there is any, otherwise nil is returned
    func getImageFromCD() -> AnyView? {
        if let b = meal.image {
            let a = UIImage(data: b)
            if a != nil {
                return AnyView(Image(uiImage: a!).resizable().renderingMode(.original).frame(width: baseImgWidth, height: baseImgWidth))
                
            }
        }
        return nil
    }
}

struct DataCoreImageView_Previews: PreviewProvider {
    static var previews: some View {
        let a = Meal(context: debugGetContext)
        return DataCoreImageView(meal: a, baseImgWidth: 200).setCD()
    }
}
