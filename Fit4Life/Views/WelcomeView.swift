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
                        .foregroundColor(Color(.indigo)) // Title text color
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        // Create new group functionality
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.indigo)
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
struct GoalHeaderView: View {
    var goal: Goal
    var onEdit: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            Text("\(goal.title) \(goal.emoji)")
                .font(.largeTitle)
                .foregroundColor(.indigo)
            
            Spacer()
            
            Button(action: onEdit) {
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(.indigo)
                    .font(.title)
            }
            
            Button(action: onDelete) {
                Image(systemName: "trash.circle.fill")
                    .foregroundColor(.indigo)
                    .font(.title)
            }
        }
        .padding()
    }
}



struct ProgressCircleView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(.indigo, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(progress * 100, specifier: "%.0f")%")
                .font(.title)
        }
        .frame(width: 200, height: 200)
        .padding()
    }
}

struct ProgressEntryView: View {
    var entry: ProgressEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(entry.amount, specifier: "%.1f")")
                    .font(.headline)
                if !entry.note.isEmpty {
                    Text(entry.note)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Text(entry.date, style: .time)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.teal.opacity(0.2)))
        .padding(.horizontal)
    }
}

struct GoalDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var progressAmount = ""
    @State private var progressNote = ""
    @State private var showingAddProgress = false
    @State private var showingEditSheet = false
    
    var goal: Goal
    
    var progressPercentage: Double {
        guard goal.dailyTarget > 0 else { return 0 }
        return min(goal.progress / goal.dailyTarget, 1.0)
    }
    
    var body: some View {
        ZStack {
            Color(.teal.opacity(0.2))
                .ignoresSafeArea(edges: .all)
            
            VStack {
                GoalHeaderView(
                    goal: goal,
                    onEdit: { showingEditSheet = true },
                    onDelete: {
                        modelContext.delete(goal)
                        dismiss()
                    }
                )
                
                Text("Daily Target: \(goal.dailyTarget, specifier: "%.1f")")
                    .font(.headline)
                
                ProgressCircleView(progress: progressPercentage)
                    .padding(.bottom, 30)
                
//                Text("Entries")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(.indigo)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal)
                
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(goal.entries) { entry in
                            ProgressEntryView(entry: entry)
                        }
                    }
                }
                
                Spacer()
                
                Button("Add Progress") {
                    showingAddProgress = true
                }
                .customButtonStyle()
                .padding(.bottom)
            }
            .sheet(isPresented: $showingAddProgress) {
                NavigationView {
                    Form {
                        TextField("Amount", text: $progressAmount)
                            .keyboardType(.decimalPad)
                        TextField("Note (optional)", text: $progressNote)
                    }
                    .navigationTitle("Add Progress")
                    .navigationBarItems(
                        leading: Button("Cancel") { showingAddProgress = false },
                        trailing: Button("Save") {
                            if let amount = Double(progressAmount) {
                                addProgress(amount: amount)
                            }
                        }
                    )
                }
            }
            .sheet(isPresented: $showingEditSheet) {
                EditGoalView(goal: goal)
            }
        }
    }
    
    private func addProgress(amount: Double) {
        let entry = ProgressEntry(amount: amount, note: progressNote)
        goal.entries.insert(entry, at: 0)
        goal.progress = amount
        showingAddProgress = false
        progressAmount = ""
        progressNote = ""
        try? modelContext.save()
    }
}

struct SmallProgressCircleView: View {
    var goal: Goal
    
    var progressPercentage: Double {
        guard goal.dailyTarget > 0 else { return 0 }
        return min(goal.progress / goal.dailyTarget, 1.0)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray.opacity(0.3), lineWidth: 5)
            Circle()
                .trim(from: 0, to: progressPercentage)
                .stroke(.indigo, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(progressPercentage * 100, specifier: "%.0f")%")
                .font(.caption)
        }
        .frame(width: 40, height: 40)
    }
}

struct GoalsOverviewView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]
    @State private var showingAddGoal = false
    @State private var selectedGoal: Goal?
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            Color(.teal.opacity(0.2))
                .ignoresSafeArea(edges: .all)
            
            VStack {
                HStack {
                    Text("Goals")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        showingAddGoal = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.indigo)
                    }
                    .padding(.trailing)
                }
                .padding(.top, 20)
                
                ScrollView {
                    ForEach(goals) { goal in
                        NavigationLink(destination: GoalDetailView(goal: goal)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(goal.title) \(goal.emoji)")
                                        .font(.headline)
                                    Text(goal.goalDetail)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                SmallProgressCircleView(goal: goal)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.teal.opacity(0.2)))
                            .padding(.horizontal)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                selectedGoal = goal
                                isEditing = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                            
                            Button(role: .destructive) {
                                modelContext.delete(goal)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                
                NavigationLink(destination: CommunityView()) {
                    Text("Go to Community")
                        .customButtonStyle()
                }
                .padding()
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

struct EditGoalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var goal: Goal
    
    @State private var title: String
    @State private var emoji: String
    @State private var goalDetail: String
    @State private var progress: Double
    @State private var dailyTargetString: String
    
    init(goal: Goal) {
        self.goal = goal
        _title = State(initialValue: goal.title)
        _emoji = State(initialValue: goal.emoji)
        _goalDetail = State(initialValue: goal.goalDetail)
        _progress = State(initialValue: goal.progress)
        _dailyTargetString = State(initialValue: String(goal.dailyTarget))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Goal Details")) {
                    TextField("Title", text: $title)
                    TextField("Emoji", text: $emoji)
                    TextField("Goal Detail", text: $goalDetail)
                    TextField("Target Amount", text: $dailyTargetString)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Edit Goal")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    if let dailyTarget = Double(dailyTargetString) {
                        goal.title = title
                        goal.emoji = emoji
                        goal.goalDetail = goalDetail
                        goal.progress = progress
                        goal.dailyTarget = dailyTarget
                        
                        try? modelContext.save()
                        dismiss()
                    }
                }
            )
        }
    }
}

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color(.teal.opacity(0.075))
                .ignoresSafeArea()
            
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




