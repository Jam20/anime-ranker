//
//  Htmx.swift
//  
//
//  Created by James Brouckman on 8/13/23.
//

import Foundation
import Vapor
import Html
import HtmlVaporSupport

public let htmxScript = Node.script(attributes: [
    .src("https://unpkg.com/htmx.org@1.9.4"),
    .crossorigin(.anonymous),
    Attribute<Tag.Script>("integrity", "sha384-zUfuhFKKZCbHTY6aRR46gxiqszMk5tcHjsVFxnUo8VMus4kHGVdIYVbOYYNlKmHV")
])

public let htmxJsonExtensionScript = Node.script(safe: "https://unpkg.com/htmx.org/dist/ext/json-enc.js")

extension Attribute {
    static func hxExt(_ type: HTMXExtension) -> Attribute {
        .init("hx-ext", type.getString())
    }
    static func hxVals(_ value: Codable) throws -> Attribute {
        return .init("hx-vals", String(data: try JSONEncoder().encode(value), encoding: .ascii))
    }
    static func hxGet(_ endpoint: String) -> Attribute {
        return .init("hx-get", endpoint)
    }
    
    static func hxPost(_ endpoint: String) -> Attribute {
        return .init("hx-post", endpoint)
    }
    
    static func hxTarget(_ target: HTMXTarget) -> Attribute {
        return .init("hx-target", target.getString())
    }
    
    static func hxParams(_ params: HTMXParams) -> Attribute {
        return .init("hx-params", params.getString())
    }
}

extension Html.Node: AsyncResponseEncodable {
    public func encodeResponse(for request: Request) async throws -> Response {
        try await encodeResponse(for: request).get()
    }
}

public enum HTMXExtension {
    case json
    
    func getString() -> String {
        switch self {
            
        case .json:
            return "json-enc"
        }
    }
}

public enum HTMXParams {
    case all
    case none
    case not([String])
    case only([String])
    
    fileprivate func getString() -> String {
        switch self {
            
        case .all:
            return "*"
        case .none:
            return "none"
        case .not(let list):
            return "not " + list.joined(separator: ",")
        case .only(let list):
            return list.joined(separator: ",")
        }
    }
}

public enum HTMXTarget {
    case closest(String)
    case this
    case next(String)
    case previous(String)
    case find(String)
    case id(String)
    
    fileprivate func getString() -> String {
        switch self {
        case .closest(let selector):
            return "closest \(selector)"
        case .this:
            return "this"
        case .next(let selector):
            return "next \(selector)"
        case .previous(let selector):
            return "previous \(selector)"
        case .find(let selector):
            return "find \(selector)"
        case .id(let selector):
            return "#\(selector)"
        }
    }
}

