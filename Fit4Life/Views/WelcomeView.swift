//
//  WelcomeView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI


// Community View
struct CommunityView: View {
    let conversations = [
        Conversation(title: "Runners GC", subtext: "10 new messages"),
        Conversation(title: "Accountability Partner", subtext: "Gym Bro: Skipping leg day again I see..."),
        Conversation(title: "Utah Fit4Life Crew", subtext: "Scott: Anyone in the Park City area interested..."),
        Conversation(title: "Mom", subtext: "Mom: Hi sweetie! I made you your protein shake..."),
        Conversation(title: "Creepy Stocker Guy", subtext: "Craig: You were looking REAL good today ..."),
        Conversation(title: "CBum", subtext: "You: I love you CBum, please text me ..."),
        Conversation(title: "Mom", subtext: "Mom: Hi sweetie! I made you your protein shake..."),
        Conversation(title: "Dad", subtext: "Dad: I'm finally proud of you son ..."),
        Conversation(title: "Lifters GC", subtext: "10 new messages"),
        Conversation(title: "Gym Bro", subtext: "Gym Bro: Skipping leg day again I see..."),
        Conversation(title: "Mom", subtext: "Mom: Hi sweetie! I made you your protein shake..."),
        Conversation(title: "Utah Fit4Life Crew", subtext: "Scott: Anyone in the Park City area interested...")
    ]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(edges: .all)
            VStack {
                HStack {
                    // Title at the top-left
                    Text("Community")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("ButtonColor")) // Title text color
                        .padding(.leading)
                    
                    Spacer() // Push the button to the right
                    
                    // Add button at the top-right
                    Button(action: {
                        // Create new group functionality
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.purple) // Deep purple color
                    }
                    .padding(.trailing)
                }
                .padding(.top, 20) // Space between top edge and title + button
                
                ScrollView {
                    ForEach(conversations) { conversation in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(conversation.title)
                                    .font(.headline)
                                    .foregroundColor(.black) // White text for dark mode
                                Text(conversation.subtext)
                                    .font(.subheadline)
                                    .foregroundColor(.gray) // Secondary text lighter
                            }
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.teal.opacity(0.2))
                        )
//                        .overlay(RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color("AccentColor"), lineWidth: 1)) // Optional border
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
        }
    }


}

// Line Chart View (Placeholder)
struct LineChartView: View {
    var goal: Goal
    var timeRange: String
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea(edges: .all)
            // Placeholder for the actual chart
            Image("LineGraph")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.1))
        }
    }
}

// Goal Detail View
struct GoalDetailView: View {
    var goal: Goal
    @State private var selectedTimeRange = "Daily"
    @State private var dailyEffort = 50
    let timeRanges = ["Daily", "Weekly", "Monthly", "Yearly"]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea(edges: .all)
            
            VStack {
                Text("\(goal.title) \(goal.emoji)")
                    .font(.largeTitle)
                    .foregroundColor(.indigo) // Deep indigo highlight
                    .padding()
                
                // Daily effort and button
                HStack {
                    Text("Today's effort: \(dailyEffort)%")
                        .foregroundColor(.primary) // White text for dark mode
                    Spacer()
                    Button(action: {
                        if dailyEffort < 100 {
                            dailyEffort += 10
                        }
                    }) {
                        Text("Add Effort")
                            .customButtonStyle()
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
                        .customButtonStyle()
                }
                .padding()
            }
        }
    }
}

// Goals Overview View
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

struct WelcomeView: View {
    @State private var showText = false
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea(edges: .all)
            VStack {
                Image("Fit4Life")
                    .resizable()
                    .frame(width: 500, height: 500)
                NavigationLink {
                    GoalsOverviewView()
                } label: {
                    Text("Continue")
                        .customButtonStyle()
                }
                .padding()
            }
        }
    }
}


#Preview {
    WelcomeView()
} // option + command + return

