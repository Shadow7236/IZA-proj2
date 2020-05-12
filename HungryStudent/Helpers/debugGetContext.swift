//
//  debugGetContext.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import CoreData
import UIKit
import SwiftUI

#if DEBUG
var debugGetContext: NSManagedObjectContext {
    (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

func wrapToContext<T: View>(_ c: T) -> some View {
    c.environment(\.managedObjectContext, debugGetContext)
}
extension View {
    func setCD() -> some View {
        wrapToContext(self)
    }
}
#endif
