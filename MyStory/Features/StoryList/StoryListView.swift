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
    
    var body: some View {
            
            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {
                LazyHStack(spacing: 0) {
                    ForEach(users, id: \.id) { user in
                        AvatarView(user: user)
                            .padding(.all, 8)
                    }
                }
            }
            .onAppear(perform: {
                Task {
                    users = try await viewModel.loadUsers()
                }
            })
    }
}

#Preview {
    StoryListView()
}
