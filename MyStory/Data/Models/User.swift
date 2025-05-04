//
//  User.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: Int
    let username: String
    let avatarURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case username = "name"
        case avatarURL = "profile_picture_url"
    }
}
