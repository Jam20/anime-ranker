//
//  File.swift
//  
//
//  Created by James Brouckman on 8/19/23.
//

import Foundation

struct FileStorage {
    let fileLocation: URL
    let fileManager: FileManager = FileManager.default
    
    func updateFile(_ data: Data) throws {
        print(fileLocation.relativeString)
        try fileManager.removeItem(at: fileLocation)
        fileManager.createFile(atPath: fileLocation.relativeString, contents: data)
    }
    func getData() throws -> Data? {
        let fileHandle = try FileHandle(forReadingFrom: fileLocation)
        return try fileHandle.readToEnd()
    }
}
