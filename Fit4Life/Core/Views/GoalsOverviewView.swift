//
//  GoalsOverviewView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI
import SwiftData

struct GoalsOverviewView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]
    @State private var showingAddGoal = false
    
    var body: some View {
        VStack {
            List {
                ForEach(goals) { goal in
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
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            modelContext.delete(goal)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())  // This removes the default list styling
            
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
            AddGoalView()
        }
        .background(Color("BackgroundColor"))
    }
}

//struct GoalsOverviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            GoalsOverviewView()
//        }
//    }
//}

