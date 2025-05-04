//
//  StoryView.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import SwiftUI

struct StoryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var currentIndex = 0
    
    var story: Story
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                let storyItem = story.items[currentIndex]
                
                AsyncImage(url: storyItem.imageURL){ image in
                    image
                        .resizable()
                    
                } placeholder: {
                    ProgressView()
                }
                .id(currentIndex)
                
                                
                VStack {
                    
                    createProgressView()
                    Spacer()
                    HStack(spacing: 0) {
                        
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            }
                        
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if currentIndex < story.items.count - 1 {
                                    currentIndex += 1
                                }
                            }
                    }
                    .frame(height: 200)
                    
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
            ForEach(0...story.items.count - 1, id: \.self) { index in
                Capsule()
                    .fill(index <= currentIndex ? Color.white.opacity(0.9) : Color.white.opacity(0.2))
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
        story: Story(
            id: UUID(),
            user: User(
                id: 1,
                username: "Brahim",
                avatarURL: URL(string: "https://i.pravatar.cc/300?u=1")!
            ),
            items: [
                StoryItem(
                    id: UUID(),
                    imageURL: URL(string: "https://picsum.photos/seed/\(1)/200/200")!
                ),
                
                StoryItem(
                    id: UUID(),
                    imageURL: URL(string: "https://picsum.photos/seed/\(2)/200/200")!
                )
            ]
        )
    )
}


