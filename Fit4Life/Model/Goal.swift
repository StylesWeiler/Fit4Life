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
    @Attribute(.unique) var id: UUID
    var title: String
    var emoji: String
    var goalDetail: String
    var progress: Double
    
    init(title: String, emoji: String, goalDetail: String, progress: Double = 0.0) {
        self.id = UUID()
        self.title = title
        self.emoji = emoji
        self.goalDetail = goalDetail
        self.progress = progress
    }
}
