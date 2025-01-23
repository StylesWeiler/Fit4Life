//
//  Fit4LifeApp.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI
import SwiftData
import Firebase

extension View {
    func commonBackground() -> some View {
        self.background(Color("BackgroundColor")
            .ignoresSafeArea(edges: .all))
    }
}

@main
struct Fit4LifeApp: App {
    @StateObject var viewModel = AuthViewModel()
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Goal.self)
            FirebaseApp.configure()
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
            .environmentObject(viewModel)
            .commonBackground()
        }
    }
}

