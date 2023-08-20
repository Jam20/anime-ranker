//
//  File.swift
//  
//
//  Created by James Brouckman on 8/19/23.
//

import Foundation

class MemoryUserStorage: UserStorage {
    private var memDB: [String: RankedList] = [:]
    
    func get(_ username: String) -> RankedList? {
        return memDB[username]
    }
    
    func set(username: String, value: RankedList) {
        memDB[username] = value
    }
}


