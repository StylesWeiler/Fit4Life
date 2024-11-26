//
//  AddGoalView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 11/25/24.
//

import SwiftUI

struct AddGoalView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: GoalViewModel
    
    @State private var title = ""
    @State private var emoji = ""
    @State private var goalDetail = ""
    
    // Common emojis for fitness goals
    let commonEmojis = ["🏃‍♂️", "💪", "🏋️‍♂️", "🚴‍♂️", "🧘‍♂️", "💧", "🥗", "⚡️", "❤️", "🎯"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Goal Information")) {
                    TextField("Goal Title", text: $title)
                    
                    TextField("Goal Details", text: $goalDetail)
                }
                
                Section(header: Text("Choose an Emoji")) {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 30))
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
                    if !title.isEmpty && !emoji.isEmpty {
                        viewModel.addGoal(title: title, emoji: emoji, goalDetail: goalDetail)
                        dismiss()
                    }
                }
                .disabled(title.isEmpty || emoji.isEmpty)
            )
        }
    }
}
