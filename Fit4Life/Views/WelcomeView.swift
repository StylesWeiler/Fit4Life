//
//  WelcomeView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI
import SwiftData


// Community View
struct CommunityView: View {
    // @Query private var conversations: [Conversation]
    
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
            Color(.teal.opacity(0.2))
                .ignoresSafeArea(edges: .all)
            VStack {
                HStack {
                    // Title at the top-left
                    Text("Community")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("ButtonColor")) // Title text color
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        // Create new group functionality
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.purple)
                    }
                    .padding(.trailing)
                }
                .padding(.top, 20)
                
                ScrollView {
                    ForEach(conversations) { conversation in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(conversation.title)
                                    .font(.headline)
                                    .foregroundColor(.black) // White text for dark mode
                                Text(conversation.subtext)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.teal.opacity(0.2))
                        )
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
            Color(.teal.opacity(0.2))
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
            Color(.teal.opacity(0.2))
                .ignoresSafeArea(edges: .all)
            
            VStack {
                Text("\(goal.title) \(goal.emoji)")
                    .font(.largeTitle)
                    .foregroundColor(.indigo)
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
            }
        }
    }
}

// Goals Overview View
struct GoalsOverviewView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]
    @State private var showingAddGoal = false
    @State private var selectedGoal: Goal?
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.teal.opacity(0.2))
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Goals")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("ButtonColor"))
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            showingAddGoal = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.purple)
                        }
                        .padding(.trailing)
                    }
                    .padding(.top, 20)
                    
                    List {
                        ForEach(goals) { goal in
                            NavigationLink(destination: GoalDetailView(goal: goal)) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(goal.title) \(goal.emoji)")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Text(goal.goalDetail)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    ProgressView(value: goal.progress)
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .frame(width: 50, height: 50)
                                }
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.teal.opacity(0.2))
                            )
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    modelContext.delete(goal)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    selectedGoal = goal
                                    isEditing = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    NavigationLink(destination: CommunityView()) {
                        Text("Go to Community")
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(Color("ButtonColor"))
                            .cornerRadius(10)
                            .customButtonStyle()
                    }
                    .padding(.bottom)
                }
            }
            .sheet(isPresented: $showingAddGoal) {
                AddGoalView()
            }
            .sheet(isPresented: $isEditing) {
                if let goalToEdit = selectedGoal {
                    EditGoalView(goal: goalToEdit)
                }
            }
        }
    }
}

struct EditGoalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var goal: Goal
    
    @State private var title: String
    @State private var emoji: String
    @State private var goalDetail: String
    @State private var progress: Double
    
    init(goal: Goal) {
        self.goal = goal
        _title = State(initialValue: goal.title)
        _emoji = State(initialValue: goal.emoji)
        _goalDetail = State(initialValue: goal.goalDetail)
        _progress = State(initialValue: goal.progress)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Goal Details")) {
                    TextField("Title", text: $title)
                    TextField("Emoji", text: $emoji)
                    TextField("Goal Detail", text: $goalDetail)
                    Slider(value: $progress, in: 0...1, step: 0.1) // need to improve
                }
            }
            .navigationTitle("Edit Goal")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    goal.title = title
                    goal.emoji = emoji
                    goal.goalDetail = goalDetail
                    goal.progress = progress
                    
                    try? modelContext.save()
                    dismiss()
                }
            )
        }
    }
}

struct WelcomeView: View {
    @State private var showText = false
    
    var body: some View {
        ZStack{
            Color(.teal.opacity(0.075))
                .ignoresSafeArea(edges: .all)
            VStack {
                Image("Fit4Life")
                    .resizable()
                    .frame(width: 500, height: 500)
                NavigationLink {
                    GoalsOverviewView()
                        .modelContainer(for: Goal.self)
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

