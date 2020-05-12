//
//  MealDetail.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct MealDetail: View {
    
    
    var body: some View {
        VStack(alignment: .center){
            AddImage()
            VStack{
                HStack{
                    Text("Name of meal")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text("Stars")
                }
                .padding()
                Text("Receipt")
                    .padding()
                Text("note")
                    .padding()
                HStack{
                    Text("Ingredients")
                        .font(.title)
                    Spacer()
                }
                .padding()
                Text("enum of ing")
            }
        Spacer()
        }
    }
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail()
    }
}
