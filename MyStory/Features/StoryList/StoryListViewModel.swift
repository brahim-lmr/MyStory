//
//  StoryListViewModel.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import Foundation

final class StoryListViewModel: ObservableObject {
    
    init() {}
    
    func loadUsers() async throws -> [User] {
        
        let pages = try await StoryLoader.loadPages()
        
        let totalUsers = pages.flatMap { $0.users }
        
        return totalUsers
    }
}
