//
//  MealImage.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  View for add image icon. With possibility of resizeing it

import SwiftUI

struct AddImage: View {
    var baseWidth: CGFloat = 200
    var computedWidth: CGFloat { baseWidth * 0.35 }
    var rad: CGFloat { computedWidth / 2 }
    var bottomPaddingMinus: CGFloat { -0.05 * baseWidth}
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "camera").resizable()
            .scaledToFit()
                .frame(width: baseWidth, height: baseWidth)
            Image(systemName: "plus.circle.fill").resizable()
                .scaledToFit()
                .frame(width: computedWidth, height: computedWidth)
                .foregroundColor(.green)
                .background(Color.white)
                .cornerRadius(rad)
                .padding(.bottom, bottomPaddingMinus)
                .padding(.trailing, bottomPaddingMinus * 2)
        }.padding(.bottom, bottomPaddingMinus * -1)
    }
}

struct AddImage_Previews: PreviewProvider {
    static var previews: some View {
        AddImage(baseWidth: 100)
    }
}
