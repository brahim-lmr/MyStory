//
//  StoryLoaderTests.swift
//  MyStoryTests
//
//  Created by Brahim Lamri on 04/05/2025.
//

import XCTest
@testable import MyStory

final class StoryLoaderTests: XCTestCase {
    
    func test_loadPages_decodesCorrectNumberOfPagesAndUsers() throws {
        
        let expectation = XCTestExpectation(description: "Load Pages")
        
        var pages: [Page] = []
        
        // Act
        Task {
            do {
                pages = try await StoryLoader.loadPages()
                
                // Assert
                XCTAssertEqual(pages.count, 3, "Expected 3 pages in total")

                let totalUsers = pages.flatMap { $0.users }
                XCTAssertEqual(totalUsers.count, 30, "Expected 30 users total (10 per page)")
                
            } catch {
                XCTFail("Failed to load pages: \(error)")
            }
            
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func test_loadStoriesFromPage_mapsUsersToStories() throws {
        
        let expectation = XCTestExpectation(description: "Load first page")
        
        var pages: [Page] = []
        
        Task {
            do {
                pages = try await StoryLoader.loadPages()
                let firstPage = pages[0]
                
                let stories = StoryLoader.loadStoriesFromPage(firstPage)

                // Assert
                XCTAssertEqual(stories.count, firstPage.users.count)
                XCTAssertTrue(stories.allSatisfy { $0.items.count > 0 }, "Each story should have at least one item")
                
            } catch {
                XCTFail("Failed to load pages: \(error)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
        
    }
}
