//
//  File.swift
//  
//
//  Created by James Brouckman on 8/19/23.
//

import Foundation

actor FileAnimeStorage: AnimeStorage {
    private var memDB: [Int: InternalAnime]
    private let fileStorage: FileStorage
    private var writeTask: Task<Void, Error>?
    
    init(_ fileStorage: FileStorage) throws {
        self.fileStorage = fileStorage
        memDB = [:]
        guard let data = try fileStorage.getData() else { return }
        memDB = try JSONDecoder().decode([Int: InternalAnime].self, from: data)
    }
    
    func get(_ id: Int) -> Anime? {
        memDB[id]?.getAnime(id)
    }
    
    func add(_ anime: Anime) throws {
        try self.add([anime])
    }
    
    func add(_ animes: [Anime]) throws {
        for anime in animes {
            memDB[anime.id] = InternalAnime(anime)
        }
        try fileStorage.updateFile(JSONEncoder().encode(memDB))
    }
}


private struct InternalAnime: Codable {
    let title: String
    let imageURL: URL
    
    init(_ anime: Anime) {
        self.title = anime.title
        self.imageURL = anime.imageURL
    }
    
    func getAnime(_ id: Int) -> Anime {
        Anime(id: id, title: title, imageURL: imageURL)
    }
}
