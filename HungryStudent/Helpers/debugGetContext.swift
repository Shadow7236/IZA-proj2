//
//  debugGetContext.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  Gets context for previews in debug.

import CoreData
import UIKit
import SwiftUI

#if DEBUG
/// Assigning context.
var debugGetContext: NSManagedObjectContext {
    (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}

/// Wraps view to debug context.
/// - Parameter c: context
/// - Returns: wrapped view
func wrapToContext<T: View>(_ c: T) -> some View {
    c.environment(\.managedObjectContext, debugGetContext)
}

/// View Extension to set context for debug.
extension View {
    /// Wraps view to debug context.
    /// - Returns: wrapped view
    func setCD() -> some View {
        wrapToContext(self)
    }
}
#endif
