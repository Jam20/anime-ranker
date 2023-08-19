//
//  File.swift
//  
//
//  Created by James Brouckman on 8/18/23.
//

import Foundation
import Vapor
import Html

private let styles: StaticString = """
@media (prefers-color-scheme: dark) {
  html {
    color-scheme: dark;
  }
  body {
    overflow: hidden;
  }
}
"""

func index(request: Request) -> Node {
    Node.html(
        .head(
            .style(safe: styles),
            .title("Anime Ranker"),
            ChildOf(htmxScript)
        ),
        .body (
            loginScreen()
        )
    )
}
