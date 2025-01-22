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
    @State private var units = ""
    @State private var quantityString = ""
    @State private var showingInvalidInputError = false
    
    let commonEmojis = ["🏃‍♂️", "💪", "🏋️‍♂️", "🚴‍♂️", "🧘‍♂️", "💧", "🥗", "⚡️", "❤️", "🎯"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Goal Title")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextField("e.g., Daily Walking", text: $title)
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Quantity")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("e.g., 10000", text: $quantityString)
                                .keyboardType(.decimalPad)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Units")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextField("e.g., steps", text: $units)
                        }
                    }
                } header: {
                    Text("Goal Information")
                }
                
                Section(header: Text("Choose an Icon")) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))], spacing: 10) {
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
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let quantity = Double(quantityString) {
                            let goal = Goal(
                                title: title,
                                emoji: emoji,
                                goalDetail: units,
                                dailyTarget: quantity
                            )
                            modelContext.insert(goal)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty || emoji.isEmpty || Double(quantityString) == nil || units.isEmpty)
                }
            }
        }
    }
}
