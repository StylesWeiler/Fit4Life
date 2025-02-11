//
//  MacroNutrientCard.swift
//  Fit4Life
//
//  Created by Styles Weiler on 2/10/25.
//


import SwiftUI

struct MacroNutrientCard: View {
    var calories: Int
    var protein: Double
    var carbs: Double
    var fats: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Nutritional Breakdown")
                .font(.headline)
                .foregroundColor(.white)
                
            HStack {
                VStack(alignment: .leading) {
                    Text("Calories")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(calories) calories")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Protein")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(protein, specifier: "%.1f")g")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Carbs")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(carbs, specifier: "%.1f")g")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Fats")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(fats, specifier: "%.1f")g")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue.opacity(0.8)))
        .padding(.horizontal)
    }
}
