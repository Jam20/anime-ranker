//
//  File.swift
//  
//
//  Created by James Brouckman on 8/19/23.
//

import Foundation
import Html

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

func animeSelectionView(username: String, leftToSort: Int, left: Anime, right: Anime) throws -> Node {
    Node.div(attributes: [.style(safe: "display: inline-grid;")],
         .h1(attributes: [.style(safe: headerStyle)],
             .text("\(leftToSort) anime left to sort")
         ),
         .div(attributes: [.style(safe: subDivStyle)],
              try animeView(user: username, anime: left),
              try animeView(user: username, anime: right)
             )
    )
}
