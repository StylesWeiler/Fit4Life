//
//  GoalsOverviewView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI

struct GoalsOverviewView: View {
    @StateObject private var viewModel = GoalViewModel()
    @State private var showingAddGoal = false
    
    let goals = [
        Goal(title: "Water", emoji: "💧", goalDetail: "1 gal/day", progress: 0.5),
        Goal(title: "Exercise", emoji: "🏋️‍♂️", goalDetail: "30 mins/day", progress: 0.3),
        Goal(title: "Sunlight", emoji: "☀️", goalDetail: "20 mins/day", progress: 0.8)
    ]
    

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.goals) { goal in
                    NavigationLink(destination: GoalDetailView(goal: goal)) {
                        VStack(alignment: .leading) {
                            Text("\(goal.emoji) \(goal.title)")
                                .font(.headline)
                            HStack {
                                Text(goal.goalDetail)
                                Spacer()
                                ProgressView(value: goal.progress)
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))
                        .padding(.horizontal)
                    }
                }
            }
            Spacer()
            Button(action: {
                showingAddGoal = true
            }) {
                Text("Add New Goal")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $showingAddGoal) {
            AddGoalView(viewModel: viewModel)
        }
    }
}

struct GoalsOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GoalsOverviewView()
        }
    }
}

