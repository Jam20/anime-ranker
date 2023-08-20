//
//  File.swift
//  
//
//  Created by James Brouckman on 8/19/23.
//

import Foundation

actor FileUserStorage: UserStorage {
    private let fileStorage: FileStorage
    private var memDB: [String: RankedList]
    private var fileTask: Task<Void, Error>?
    
    init(_ fileStorage: FileStorage) throws {
        self.fileStorage = fileStorage
        self.memDB = [:]
        guard let data = try fileStorage.getData() else { return }
        memDB = try JSONDecoder().decode([String: RankedList].self, from: data)
    }
    
    func get(_ username: String) async throws -> RankedList? {
        memDB[username]
    }
    
    func set(username: String, value: RankedList) async throws {
        memDB[username] = value
        try fileStorage.updateFile(JSONEncoder().encode(memDB))
    }
}
