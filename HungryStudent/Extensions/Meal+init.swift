//
//  Meal+init.swift
//  HungryStudent
//
//  Created by Radovan Klembara on 13/05/2020.
//  Copyright © 2020 Radovan Klembara. All rights reserved.
//

import CoreData

extension Meal {
    convenience init(name: String, note: String, receipt: String, ings: NSSet? = nil, mealType: MealType) {
        self.init(context: AppDelegate.current.persistentContainer.viewContext)
        id = UUID()
        image = nil
        isFavourite = false
        self.name = name
        self.note = note
        self.receipt = receipt
        if let i = ings {
            addToIngrediences(i)
        }
        self.mealType = mealType
        score = 0
    }
}

