//
//  UIApplicationDelegate+current.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 12/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//
// Extension for UIApplicationDelegate to be assigned to App Delegate

import UIKit

extension AppDelegate {
    static var current: AppDelegate {
        (UIApplication.shared.delegate as! AppDelegate)
    }
}
