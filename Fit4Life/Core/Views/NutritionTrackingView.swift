//
//  NutritionTrackingView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 2/5/25.
//


import SwiftUI

import SwiftUI

struct NutritionTrackingView: View {
    @StateObject var viewModel = NutritionViewModel()
    @State private var dailyCalories = 1250
    @State private var goalCalories = 2400
    @State private var showAddMealSheet = false
    
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
                        showAddMealSheet = true
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
                    
                    ProgressView(value: Double(viewModel.totalCalories) / Double(goalCalories))
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .frame(height: 10)
                    
                    Text("\(viewModel.totalCalories)/\(goalCalories) kcal")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                // Logged meals with delete functionality
                List {
                    ForEach(viewModel.meals) { meal in
                        VStack(alignment: .leading) {
                            Text(meal.name)
                                .font(.headline)
                            Text("\(meal.calories) kcal")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: deleteMeal) // Enable swipe-to-delete
                }
                .listStyle(InsetGroupedListStyle())
                
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showAddMealSheet) {
            AddMealView(viewModel: viewModel) // Show AddMealView for input
        }
    }
    
    // Delete meal function
    private func deleteMeal(at offsets: IndexSet) {
        for index in offsets {
            viewModel.removeMeal(at: index)
        }
    }
}
