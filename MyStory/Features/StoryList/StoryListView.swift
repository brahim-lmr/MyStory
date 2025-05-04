//
//  StoryListView.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import SwiftUI

struct StoryListView: View {
    
    @StateObject var viewModel = StoryListViewModel()
    
    @State private var users: [User] = []
    
    @State private var selectedUser: User?

    var body: some View {
            
        NavigationStack {
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                LazyHStack(spacing: 0) {
                    ForEach(users, id: \.id) { user in
                        AvatarView(user: user)
                            .padding(.all, 8)
                            .onTapGesture {
                                selectedUser = user
                            }
                    }
                }
            }
            .navigationTitle("Stories")
            .fullScreenCover(item: $selectedUser) { user in
                   StoryView(user: user)
            }
            .task {
                do {
                    users = try await viewModel.loadUsers()
                } catch {
                    
                }
            }
        }
    }
}

#Preview {
    StoryListView()
}
