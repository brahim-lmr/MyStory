//
//  AvatarView.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import SwiftUI

struct AvatarView: View {
    
    let imageUrl: URL
    
    var body: some View {
        AsyncImage(url: imageUrl) { image in
            image
                .resizable()
                .frame(width: 100, height: 100)
            
        } placeholder: {
            Color.gray.opacity(0.3)
        }
        .clipShape(Circle())
        .background(
            Circle()
                .stroke(Color.pink, lineWidth: 4)
                .frame(width: 110, height: 110)
        )
    }
}

#Preview {
    AvatarView(imageUrl: URL(string: "https://i.pravatar.cc/300?u=1")!)
}
