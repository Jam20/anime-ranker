//
//  LoginScreen.swift
//  
//
//  Created by James Brouckman on 8/13/23.
//

import Foundation
import Html

private let container: StaticString = """
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
  overflow: hidden;
  margin: 0
"""
private let textBox: StaticString = """
  margin: 2vh;
  align-self: center;
"""
func loginScreen() -> Node {
    let endpoint = "/users"
    return Node.div( attributes: [.style(safe: container)],
              .h1("Anime Ranker Utility"),
              .form( attributes: [ .hxGet(endpoint),
                                   .hxTarget(.closest("div")),
                                   .hxParams(.only(["username"]))
              ],
                     .input(attributes: [
                        .style(safe: textBox),
                        .placeholder("AniList Username"),
                        .name("username"),
                        .type(.text),
                        .id("username")
                     ]),
                     .button(attributes: [.type(.submit)], "Submit")
              )
    )
}


