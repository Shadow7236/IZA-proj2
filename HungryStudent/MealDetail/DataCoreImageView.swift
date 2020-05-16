//
//  DataCoreImageView.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 15/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct DataCoreImageView: View {
    
    @ObservedObject
    var meal: Meal
    
    var baseImgWidth: CGFloat = 200
    
    var body: some View {
        getImage()
    }
    
    
    
    
    func getImage() -> some View {
        guard let image = getImageFromCD() else {
            return AnyView(AddImage(baseWidth: baseImgWidth))
        }
        let img = image
            .scaledToFit()
        return AnyView(img)
    }
    
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
