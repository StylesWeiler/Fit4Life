//
//  GoalDetailView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI

struct GoalDetailView: View {
    var goal: Goal
    @State private var selectedTimeRange = "Daily"
    let timeRanges = ["Daily", "Weekly", "Monthly", "Yearly"]
    
    var body: some View {
        VStack {
            Text("\(goal.emoji) \(goal.title)")
                .font(.largeTitle)
                .padding()
            
            // Daily effort and button
            HStack {
                Text("Today's effort: 50%")
                Spacer()
                Button(action: {
                    // Add effort functionality
                }) {
                    Text("Add Effort")
                        .font(.headline)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            // Time range selection
            Picker("Time Range", selection: $selectedTimeRange) {
                ForEach(timeRanges, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Line chart view
            LineChartView(goal: goal, timeRange: selectedTimeRange)
                .frame(height: 200)
            
            Spacer()
            
            // Navigation to CommunityView
            NavigationLink(destination: CommunityView()) {
                Text("Go to Community")
                    .font(.headline)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalDetailView(goal: Goal(title: "Water", emoji: "💧", goalDetail: "1 gal/day", progress: 0.5))
        }
    }
}

