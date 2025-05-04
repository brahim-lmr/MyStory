//
//  StoryListView.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import SwiftUI

struct StoryListView: View {
    
    @StateObject var viewModel = StoryListViewModel()

    @State private var selectedUser: User?

    var body: some View {
            
        NavigationStack {
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.users, id: \.id) { user in
                        AvatarView(user: user)
                            .padding(.all, 8)
                            .onTapGesture {
                                selectedUser = user
                            }
                            .task {
                                await viewModel.loadMoreUsersIfNeeded(currentUser: user)
                            }
                    }
                }
            }
            .navigationTitle("Stories")
            .fullScreenCover(item: $selectedUser) { user in
                
                let story = viewModel.stories.filter { story in
                    story.user.id == user.id
                }.first
                
                if let story {
                    StoryView(story: story)
                } else {
                    Text("Error loading story")
                }
                
            }
            .task {
                do {
                     try await viewModel.loadInitialUsers()
                } catch {
                    
                }
            }
        }
    }
}

#Preview {
    StoryListView()
}
