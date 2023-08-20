//
//  File.swift
//  
//
//  Created by James Brouckman on 8/17/23.
//

import Foundation
import Html
import Vapor

protocol UserStorage {
    func get(_ username: String ) async throws -> RankedList?
    func set(username: String, value: RankedList) async throws
}






