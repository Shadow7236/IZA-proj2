//
//  ObservableObject+toBindable.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 13/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
//  Extension of ObservableObject to make Bindable from it.

import CoreData
import SwiftUI


/// Updates in database binded object attribute.
/// - Parameters:
///   - object: object to be updated in database
///   - keyPath: key path of changed object attribute
/// - Returns: binding of object
private func saveBinding<T, U: NSManagedObject>(object: U, keyPath: ReferenceWritableKeyPath<U, T>) -> Binding<T> {
    .init(get: { object[keyPath: keyPath] }) { newValue in
        AppDelegate.current.persistentContainer.viewContext.performAndWait {
            object[keyPath: keyPath] = newValue
            AppDelegate.current.saveContext()
        }
    }
}

/// Updates in database binded object attribute.
/// - Parameters:
///   - object: object to be updated in database
///   - keyPath: key path to object attribute
///   - defaultValue: default value
/// - Returns: Binding of object
private func saveBinding<T, U: NSManagedObject>(object: U, keyPath: ReferenceWritableKeyPath<U, T?>, defaultValue: T) -> Binding<T> {
    .init(get: { object[keyPath: keyPath] ?? defaultValue }) { newValue in
        AppDelegate.current.persistentContainer.viewContext.performAndWait {
            object[keyPath: keyPath] = newValue
            AppDelegate.current.saveContext()
        }
    }
}

/// Bindable extension.
extension ObservableObject where Self: NSManagedObject {
    
    /// Makes bindable from object with key path to not nil value.
    /// - Parameter keyPath: key path to object attribute
    /// - Returns: binding
    func toBindable<T>(keyPath: ReferenceWritableKeyPath<Self, T>) -> Binding<T> {
        saveBinding(object: self, keyPath: keyPath)
    }
    
    /// Makes bindable from object
    /// - Parameters:
    ///   - keyPath: key path to attribute
    ///   - defaultValue: default value
    /// - Returns: binding
    func toBindable<T>(keyPath: ReferenceWritableKeyPath<Self, T?>, defaultValue: T) -> Binding<T> {
        saveBinding(object: self, keyPath: keyPath, defaultValue: defaultValue)
    }
    
    /// Makes bindable from object with key path to String attribute.
    /// - Parameter keyPath: key path to attribute
    /// - Returns: binding
    func toBindable(keyPath: ReferenceWritableKeyPath<Self, String?>) -> Binding<String> {
        saveBinding(object: self, keyPath: keyPath, defaultValue: "")
    }
    
    /// Fatal error for trying to do something unreasonable.
    /// - Parameter keyPath: key path to NSSet?
    /// - Returns: fatal error (should return binding)
    func toBindable(keyPath: ReferenceWritableKeyPath<Self, NSSet?>) -> Binding<Never> {
        fatalError()
    }
}
