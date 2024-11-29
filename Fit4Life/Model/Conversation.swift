//
//  Conversation.swift
//  Fit4Life
//
//  Created by Styles Weiler on 10/16/24.
//

import SwiftData

@Model
final class Conversation {
    var title: String
    var subtext: String
    
    init(title: String, subtext: String) {
        self.title = title
        self.subtext = subtext
    }
}
