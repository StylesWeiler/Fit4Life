//
//  Goal.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftData
import Foundation

@Model
final class Goal {
    var title: String
    var emoji: String
    var goalDetail: String
    var dailyTarget: Double
    var progress: Double
    var entries: [ProgressEntry]
    
    init(title: String, emoji: String = "", goalDetail: String = "", dailyTarget: Double = 0.0, progress: Double = 0.0) {
        self.title = title
        self.emoji = emoji
        self.goalDetail = goalDetail
        self.dailyTarget = dailyTarget
        self.progress = progress
        self.entries = []
    }
}

@Model
final class ProgressEntry: Identifiable {
    var date: Date
    var amount: Double
    var note: String
    
    init(amount: Double, note: String) {
        self.date = Date()
        self.amount = amount
        self.note = note
    }
}


