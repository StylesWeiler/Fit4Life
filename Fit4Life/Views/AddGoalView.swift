//
//  AddGoalView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 11/25/24.
//

import SwiftUI
import SwiftData

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title = ""
    @State private var emoji = ""
    @State private var goalDetail = ""
    @State private var goalAmountString = ""
    @State private var showingInvalidInputError = false
    
    // Common emojis for fitness goals
    let commonEmojis = ["🏃‍♂️", "💪", "🏋️‍♂️", "🚴‍♂️", "🧘‍♂️", "💧", "🥗", "⚡️", "❤️", "🎯"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Goal Information")) {
                    TextField("Goal Title", text: $title)
                    
                    TextField("Goal Details", text: $goalDetail)
                    
                    TextField("Daily Goal Amount", text: $goalAmountString)
                        .keyboardType(.decimalPad)
                        .onChange(of: goalAmountString) { _, newValue in
                            showingInvalidInputError = Double(newValue) == nil && !newValue.isEmpty
                        }
                    
                    if showingInvalidInputError {
                        Text("Please enter a valid number.")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Choose an Emoji")) {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 50))
                    ], spacing: 10) {
                        ForEach(commonEmojis, id: \.self) { emoji in
                            Text(emoji)
                                .font(.title)
                                .padding(5)
                                .background(self.emoji == emoji ? Color.blue.opacity(0.3) : Color.clear)
                                .cornerRadius(8)
                                .onTapGesture {
                                    self.emoji = emoji
                                }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Add New Goal")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveGoal()
                }
                .disabled(title.isEmpty || emoji.isEmpty || showingInvalidInputError)
            )
        }
    }
    
    private func saveGoal() {
        let goal = Goal(
            title: title,
            emoji: emoji,
            goalDetail: goalDetail,
            progress: 0.0
        )
        
        modelContext.insert(goal)
        dismiss()
    }
}
