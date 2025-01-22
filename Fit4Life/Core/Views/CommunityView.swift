//
//  CommunityView.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/15/24.
//

import SwiftUI

struct Conversation: Identifiable {
    let id = UUID()
    let title: String
    let subtext: String
}

struct CommunityView: View {
    let conversations = [
        Conversation(title: "Lifters GC", subtext: "10 new messages"),
        Conversation(title: "Gym Partner", subtext: "Skipping leg day again I see..."),
        Conversation(title: "Mom", subtext: "Hi sweetie! I made you your protein shake...")
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(conversations) { conversation in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(conversation.title)
                                .font(.headline)
                            Text(conversation.subtext)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal)
                }
            }
            Spacer()
            Button(action: {
                // Create new group functionality
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
            }
            .padding()
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommunityView()
        }
    }
}

