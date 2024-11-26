//
//  GoalViewModel.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI

class GoalViewModel: ObservableObject {
    @Published var goals = [Goal]()
    
    func addGoal(title: String, emoji: String, goalDetail: String) {
        let newGoal = Goal(title: title, emoji: emoji, goalDetail: goalDetail, progress: 0.0)
        goals.append(newGoal)
    }
    
    // Other goal-related functions here
}
