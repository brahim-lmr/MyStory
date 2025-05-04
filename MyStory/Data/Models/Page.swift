//
//  Page.swift
//  MyStory
//
//  Created by Brahim Lamri on 04/05/2025.
//

import Foundation

struct PageList: Codable {
    let pages: [Page]
}

struct Page: Codable {
    let users: [User]
}
