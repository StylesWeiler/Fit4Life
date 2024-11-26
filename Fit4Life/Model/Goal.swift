//
//  Goal.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import Foundation

struct Goal: Identifiable {
    let id = UUID()
    let title: String
    let emoji: String
    let goalDetail: String
    let progress: Double
}
