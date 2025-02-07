//
//  Meal.swift
//  Fit4Life
//
//  Created by Styles Weiler on 2/6/25.
//


import Foundation

struct Meal: Identifiable {
    let id = UUID()
    var name: String
    var calories: Int
    var protein: Double // in grams
    var carbs: Double // in grams
    var fats: Double // in grams
    
    init(name: String, calories: Int = 0, protein: Double = 0.0, carbs: Double = 0.0, fats: Double = 0.0) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fats = fats
    }
}
