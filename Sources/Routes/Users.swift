//
//  File.swift
//  
//
//  Created by James Brouckman on 8/17/23.
//

import Foundation
import Vapor
import Html

struct SelectedAnime: Codable {
    let username: String
    let animeId: Int
}

private struct User: Codable {
    let username: String
}

func postUser(request: Request) async throws -> Node {
    let selected = try request.content.decode(SelectedAnime.self)
    return try await rankerScreen(username: selected.username, animeId: selected.animeId)
}

func getUser(request: Request) async throws -> Node {
    let username = try request.query.decode(User.self).username
    return try await rankerScreen(username: username)
}

