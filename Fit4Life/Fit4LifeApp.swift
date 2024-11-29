//
//  Fit4LifeApp.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI
import SwiftData

@main
struct Fit4LifeApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Goal.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WelcomeView()
            }
            .modelContainer(container)
        }
    }
}

