//
//  StoryLoader.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import Foundation

enum StoryLoaderError: Error {
    case failedToLoadFile
}

struct StoryLoader {
    
    static func loadPages() async throws -> [Page] {
        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
            throw StoryLoaderError.failedToLoadFile
        }
        
        let data = try Data(contentsOf: url)
        let pageList = try JSONDecoder().decode(PageList.self, from: data)
        return pageList.pages
    }
    
    static func loadStoriesFromPage(_ page: Page) -> [Story] {
        return page.users.map {
            Story(
                id: UUID(),
                user: $0,
                items: generateFakeStoryItems(for: $0),
                isSeen: false
            )
        }
    }
    
    private static func generateFakeStoryItems(for user: User) -> [StoryItem] {
        let count = Int.random(in: 1...3)
        return (1...count).map { index in
            StoryItem(
                id: UUID(),
                imageURL: URL(string: "https://picsum.photos/seed/\(user.id)\(index)/200/200")!
            )
        }
    }
}
