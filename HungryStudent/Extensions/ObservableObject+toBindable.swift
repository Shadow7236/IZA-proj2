//
//  ObservableObject+toBindable.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 13/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import CoreData
import SwiftUI

private func sB<T, U: NSManagedObject>(object: U, keyPath: ReferenceWritableKeyPath<U, T>) -> Binding<T> {
    .init(get: { object[keyPath: keyPath] }) { newValue in
        object[keyPath: keyPath] = newValue
        ///
    }
}

private func sB<T, U: NSManagedObject>(object: U, keyPath: ReferenceWritableKeyPath<U, T?>, defaultValue: T) -> Binding<T> {
    .init(get: { object[keyPath: keyPath] ?? defaultValue }) { newValue in
        AppDelegate.current.persistentContainer.viewContext.performAndWait {
            object[keyPath: keyPath] = newValue
            AppDelegate.current.saveContext()
        }
    }
}

extension ObservableObject where Self: NSManagedObject {
    func toBindable<T>(keyPath: ReferenceWritableKeyPath<Self, T>) -> Binding<T> {
        sB(object: self, keyPath: keyPath)
    }
    func toBindable<T>(keyPath: ReferenceWritableKeyPath<Self, T?>, defaultValue: T) -> Binding<T> {
        sB(object: self, keyPath: keyPath, defaultValue: defaultValue)
    }
    
    func toBindable(keyPath: ReferenceWritableKeyPath<Self, String?>) -> Binding<String> {
        sB(object: self, keyPath: keyPath, defaultValue: "")
    }
    
    func toBindable(keyPath: ReferenceWritableKeyPath<Self, NSSet?>) -> Binding<Never> {
        fatalError()
    }
}
