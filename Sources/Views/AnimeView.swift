//
//  File.swift
//  
//
//  Created by James Brouckman on 8/17/23.
//

import Foundation
import Html

private let divStyles: StaticString = """
  display: flex;
  flex-direction: column;
"""

func animeView(user: String, anime: Anime) throws -> Node {
    let endpoint = "/users"
    let selected = SelectedAnime(username: user, animeId: anime.id)
    return Node.div( attributes: [.style(safe: divStyles), ],
                     .img(src: anime.imageURL.absoluteString, alt: "Image for \(anime.title)", attributes: [.width(339), .height(500)]),
                     .button(attributes: [.hxPost(endpoint), .hxTarget(.id("ranker-screen")), try .hxVals(selected), .hxExt(.json)],
                             .text(anime.title)
                     )
    )
}
