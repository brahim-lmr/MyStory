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
            ZStack {
                AsyncImage(url: URL(string: "https://picsum.photos/300/500?random=\(UUID().uuidString)")!){ image in
                    image
                        .resizable()
                    
                } placeholder: {
                    ProgressView()
                }
                
                
                VStack {
                    
                    createProgressView()
                    
                    Spacer()
                    HStack {
                        createReactionButton(type: .like)
                        createReactionButton(type: .dislike)
                        
                    }
                    .padding(.bottom, 16)
                }
                
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
    
    private func createReactionButton(type: Reaction) -> some View {
        Button(action: {}) {
            Image(systemName: type == .dislike ? "hand.thumbsdown" : "hand.thumbsup")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            
        }
    }
    
    private func createProgressView() -> some View {
        HStack(spacing: 4) {
            ForEach(0...3, id: \.self) { index in
                Capsule()
                    .fill(Color.white)
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
                
            }
            
        }
        .padding(.top, 16)
        .padding(.horizontal, 12)
    }
    
    enum Reaction {
        case like, dislike
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
