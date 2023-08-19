//
//  File.swift
//  
//
//  Created by James Brouckman on 8/18/23.
//

import Foundation

struct Anime: Codable {
    let id: Int
    let title: String
    let imageURL: URL
    
    init(id: Int, title: String, imageURL: URL) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}
