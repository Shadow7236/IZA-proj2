//
//  Stars.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import SwiftUI

struct Stars: View {
    
    
    var body: some View {
        HStack{
            Image(systemName: "star.fill")
            }
        .foregroundColor(.yellow)
    }
}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
        Stars()
    }
}
