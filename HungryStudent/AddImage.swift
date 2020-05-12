//
//  MealImage.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct AddImage: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "camera").resizable()
            .scaledToFit()
                .frame(width: 200, height: 200)
            Image(systemName: "plus.circle.fill").resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(.green)
                .background(Color.white)
                .cornerRadius(35)
                .padding(.bottom, -10)
                .padding(.trailing, -20)
        }.padding(.bottom, 10)
    }
}

struct AddImage_Previews: PreviewProvider {
    static var previews: some View {
        AddImage()
    }
}
