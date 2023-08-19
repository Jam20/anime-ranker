//
//  File.swift
//  
//
//  Created by James Brouckman on 8/14/23.
//

import Foundation
import Html

var userStorage = UserStorage()

private let mainDivStyle: StaticString = """
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  flex-direction: row;
  overflow: hidden;
  margin: 0
"""
private let headerStyle: StaticString = """
  width: 80vw;
  justify-content: center;
  display: flex;
"""

private let subDivStyle: StaticString = """
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    width: 80vw;
"""
func rankerScreen(username: String) async throws -> Node {
    let rankedList = try await getAnimeList(username)
    let (left, right) = rankedList.getNextComparison()
    let animeLeftToSort = rankedList.unsortedList.count - rankedList.sortedList.count
    return Node.div(attributes: [.style(safe: mainDivStyle), .id("ranker-screen")],
                    animeListView(rankedList.sortedList.reversed()),
                    .div(attributes: [.style(safe: "display: inline-grid;")],
                         .h1(attributes: [.style(safe: headerStyle)],
                             .text("\(animeLeftToSort) anime left to sort")
                         ),
                         .div(attributes: [.style(safe: subDivStyle)],
                              try animeView(user: username, anime: left),
                              try animeView(user: username, anime: right)
                             )
                    )
    )
}

func rankerScreen(username: String, animeId: Int) async throws -> Node {
    var rankedList = try await getAnimeList(username)
    rankedList.resolveComparison(animeId)
    userStorage.set(username: username, animeList: rankedList)
    return try await rankerScreen(username: username)
}

private func getAnimeList(_ username: String) async throws -> RankedAnimeList {
    if let list = userStorage.get(username) {
        return list
    }
    let rawList = try await retrieveAnimeList(username)
    let rankedList = RankedAnimeList(initial: rawList)
    userStorage.set(username: username, animeList: rankedList)
    return rankedList
}





