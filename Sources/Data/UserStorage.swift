//
//  File.swift
//  
//
//  Created by James Brouckman on 8/17/23.
//

import Foundation
import Html
import Vapor

struct UserStorage {
    private var memDB: [String: RankedAnimeList] = [:]
    
    func get(_ username: String) -> RankedAnimeList? {
        return memDB[username]
    }
    
    mutating func set(username: String, animeList: RankedAnimeList) {
        memDB[username] = animeList
    }
}
