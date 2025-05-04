//
//  Story.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import Foundation

struct Story: Identifiable, Codable, Equatable {
    let id: UUID
    let user: User
    let items: [StoryItem]
    
    var isSeen: Bool = false
}
