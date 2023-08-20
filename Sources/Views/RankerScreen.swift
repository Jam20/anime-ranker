//
//  File.swift
//  
//
//  Created by James Brouckman on 8/14/23.
//

import Foundation
import Html


private let mainDivStyle: StaticString = """
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  flex-direction: row;
  overflow: hidden;
  margin: 0
"""

func rankerScreen(username: String) async throws -> Node {
    let rankedList = try await getRankedList(username)
    var listAsAnime: [Anime] = []
    for id in rankedList.getList() {
        listAsAnime.append(await animeStorage.get(id)!)
    }
    
    guard let (left, right) = rankedList.next() else {
        return Node.div(attributes: [.style(safe: mainDivStyle), .id("ranker-screen")],
                        animeListView(listAsAnime),
                        .h1("Done Sorting")
        )
    }
    
    let leftAnime = await animeStorage.get(left)!
    let rightAnime = await animeStorage.get(right)!
    
    return Node.div(attributes: [.style(safe: mainDivStyle), .id("ranker-screen")],
                    animeListView(listAsAnime),
                    try animeSelectionView(username: username, leftToSort: rankedList.leftToSort, left: leftAnime, right: rightAnime)
    )
}



func rankerScreen(username: String, animeId: Int) async throws -> Node {
    var rankedList = try await getRankedList(username)
    rankedList.resolve(animeId)
    try await userStorage.set(username: username, value: rankedList)
    return try await rankerScreen(username: username)
}

private func getRankedList(_ username: String) async throws -> RankedList {
    if let list = try await userStorage.get(username) {
        return list
    }
    let rawList = try await retrieveAnimeList(username)
    try await animeStorage.add(rawList)
    let ids = rawList.map { $0.id }
    let rankedList = RankedList(ids)
    try await userStorage.set(username: username, value: rankedList)
    return rankedList
}





