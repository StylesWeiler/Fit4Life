//
//  NutritionTrackingView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 2/5/25.
//


import SwiftUI

struct NutritionTrackingView: View {
    @State private var dailyCalories = 1500 // Example calorie count
    @State private var goalCalories = 2000 // Calorie goal
    @State private var meals: [String] = ["Breakfast - Oatmeal", "Lunch - Chicken Salad", "Dinner - Grilled Salmon"]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(edges: .all)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Nutrition Tracking")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("ButtonColor"))
                    
                    Spacer()
                    
                    Button(action: {
                        // Add new meal functionality
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.green)
                    }
                }
                .padding()
                
                // Calorie progress
                VStack(alignment: .leading) {
                    Text("Daily Calorie Intake")
                        .font(.headline)
                    
                    ProgressView(value: Double(dailyCalories) / Double(goalCalories))
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .frame(height: 10)
                    
                    Text("\(dailyCalories)/\(goalCalories) kcal")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Logged meals
                List(meals, id: \..self) { meal in
                    Text(meal)
                        .foregroundColor(.primary)
                }
                .listStyle(InsetGroupedListStyle())
                
                Spacer()
            }
            .padding()
        }
    }
}
