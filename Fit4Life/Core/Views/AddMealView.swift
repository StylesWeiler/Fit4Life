//
//  AddMealView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 2/6/25.
//


import SwiftUI

struct AddMealView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NutritionViewModel
    
    @State private var mealName = ""
    @State private var calories = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fats = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Meal Details")) {
                    TextField("Meal Name", text: $mealName)
                    TextField("Calories", text: $calories)
                        .keyboardType(.numberPad)
                    TextField("Protein (g)", text: $protein)
                        .keyboardType(.decimalPad)
                    TextField("Carbs (g)", text: $carbs)
                        .keyboardType(.decimalPad)
                    TextField("Fats (g)", text: $fats)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationBarTitle("Add Meal", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    addMeal()
                }
                .disabled(mealName.isEmpty || calories.isEmpty)
            )
        }
    }
    
    private func addMeal() {
        guard let cal = Int(calories),
              let prot = Double(protein),
              let carb = Double(carbs),
              let fat = Double(fats) else { return }
        
        viewModel.addMeal(name: mealName, calories: cal, protein: prot, carbs: carb, fats: fat)
        presentationMode.wrappedValue.dismiss()
    }
}
