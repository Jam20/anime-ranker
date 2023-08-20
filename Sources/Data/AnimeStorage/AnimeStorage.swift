//
//  File.swift
//  
//
//  Created by James Brouckman on 8/19/23.
//

import Foundation

protocol AnimeStorage {
    func get(_ id: Int) async -> Anime?
    func add(_ anime: Anime) async throws
    func add(_ animes: [Anime]) async throws
}
