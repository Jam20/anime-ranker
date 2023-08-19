//
//  File.swift
//  
//
//  Created by James Brouckman on 8/18/23.
//

import Foundation
import Html
private let mainDivStyle: StaticString = """
    display: flex;
    flex-direction: row;
    padding-left: 16px;
"""

private let h2Style: StaticString = """
    width: 3vw;
"""

private let subDivStyle: StaticString = """
    display: flex;
    flex-direction: column;
    padding-left: 8px;
    padding-right: 8px;
    border-right: 5px solid #333333;
    width: 15vw;
"""
func animeListItemView(index: Int, anime: Anime) -> Node {
    Node.div(attributes: [.style(safe: mainDivStyle)],
             .h2(attributes: [.style(safe: h2Style)], .text(String(index + 1))),
             .div(attributes: [.style(safe: subDivStyle)],
                  .img(src: anime.imageURL.absoluteString, alt: "image for \(anime.title)", attributes: [.width(51), .height(75)]),
                  .h3(.text(anime.title))
                 )
    )
}
