//
//  File.swift
//  
//
//  Created by James Brouckman on 8/19/23.
//

import Foundation

class MemoryAnimeStorage: AnimeStorage {
    private var memDB: [Int: Anime] = [:]
    
    func get(_ id: Int) -> Anime? {
        memDB[id]
    }
    
    func add(_ anime: Anime) {
        memDB[anime.id] = anime
    }
    
    func add(_ animes: [Anime]) {
        for anime in animes {
            memDB[anime.id] = anime
        }
    }
}


