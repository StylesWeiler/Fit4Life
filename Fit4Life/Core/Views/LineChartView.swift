//
//  LineChartView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI

struct LineChartView: View {
    var goal: Goal
    var timeRange: String
    
    var body: some View {
        // Placeholder for the actual chart
        Text("Line chart for \(goal.title) - \(timeRange)")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(goal: Goal(title: "Water", emoji: "💧", goalDetail: "1 gal/day", progress: 0.5), timeRange: "Daily")
    }
}

