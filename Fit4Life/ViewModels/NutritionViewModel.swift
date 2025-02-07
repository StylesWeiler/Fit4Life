//
//  NutritionViewModel.swift
//  Fit4Life
//
//  Created by Todd Weiler on 2/6/25.
//

import Foundation
import SwiftUI

class NutritionViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var totalCalories: Int = 0
    @Published var totalProtein: Double = 0
    @Published var totalCarbs: Double = 0
    @Published var totalFats: Double = 0
    
    func addMeal(name: String, calories: Int, protein: Double, carbs: Double, fats: Double) {
        let newMeal = Meal(name: name, calories: calories, protein: protein, carbs: carbs, fats: fats)
        meals.append(newMeal)
        updateTotals()
    }
    
    func removeMeal(at index: Int) {
        meals.remove(at: index)
        updateTotals()
    }
    
    private func updateTotals() {
        totalCalories = meals.reduce(0) { $0 + $1.calories }
        totalProtein = meals.reduce(0) { $0 + $1.protein }
        totalCarbs = meals.reduce(0) { $0 + $1.carbs }
        totalFats = meals.reduce(0) { $0 + $1.fats }
    }
}


