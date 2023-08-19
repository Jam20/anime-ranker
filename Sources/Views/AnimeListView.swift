//
//  File.swift
//  
//
//  Created by James Brouckman on 8/18/23.
//

import Foundation
import Html
private let divStyle: StaticString = """
    overflow-y: scroll;
    max-height: 100vh;
    min-height: 100vh;
"""

func animeListView(_ anime: [Anime]) -> Node {
    let listViewItems = anime.enumerated().map(animeListItemView)
    return Node.div( attributes: [.style(safe: divStyle)],
                     .fragment(listViewItems)
    )
}
