//
//  StoryListViewModel.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import Foundation

final class StoryListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var stories: [Story] = []
    
    private var currentPage = 1
    private var totalPages = 0
    private var isLoadingNextPage = false
    
    init() {}
    
    func loadStory(for user: User) {
        
    }
    
    private func fetchUsers(page: Int) async throws -> [User] {
        let pages = try await StoryLoader.loadPages()
        stories = StoryLoader.loadStoriesFromPage(pages[page - 1])
        
        totalPages = pages.count
        guard page - 1 < pages.count else { return [] }
        return pages[page - 1].users
    }
    
    func loadInitialUsers() async throws {
        currentPage = 1
        users = try await fetchUsers(page: currentPage)
    }
    
    func loadMoreUsersIfNeeded(currentUser user: User) async {
        guard let lastUser = users.last else { return }
        guard user.id == lastUser.id else { return }
        guard !isLoadingNextPage, currentPage < totalPages else { return }
        
        isLoadingNextPage = true
        defer { isLoadingNextPage = false }
        
        currentPage += 1
        do {
            let newUsers = try await fetchUsers(page: currentPage)
            users += newUsers
        } catch {
            // Handle error
        }
    }
    
  
}
