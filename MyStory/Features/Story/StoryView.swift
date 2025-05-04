//
//  StoryView.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import SwiftUI

struct StoryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var user: User

    var body: some View {
        NavigationStack {
            VStack {
                Text(user.username)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    StoryView(
        user: User(
            id: 1,
            username: "Brahim",
            avatarURL: URL(string: "https://i.pravatar.cc/300?u=1")!
        )
    )
}
