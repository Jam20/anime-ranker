//
//  File.swift
//  
//
//  Created by James Brouckman on 8/18/23.
//

import Foundation

struct RankedAnimeList {
    let unsortedList: [Anime]
    var sortedList: [Anime]
    private var low: Int
    private var high: Int
    private var mid: Int { (low + high) / 2 }
    
    init(initial: [Anime]) {
        self.unsortedList = initial.shuffled()
        self.sortedList = [unsortedList[0]]
        self.low = 0
        self.high = sortedList.count - 1
    }
    
    func getNextComparison() -> (Anime, Anime) {
        if sortedList.count < 2 {
            return (unsortedList[0], unsortedList[1])
        }
        return (sortedList[mid], unsortedList[sortedList.count])
    }
    
    mutating func resolveComparison(_ id: Int) {
        if mid == low && sortedList.count != 2 && mid + 1 == sortedList.count - 1 {
            low = high
            return
        }
        if mid == low {
            if id == sortedList[mid].id {
                sortedList.insert(unsortedList[sortedList.count], at: mid)
            } else if mid == sortedList.count - 1 {
                sortedList.append(unsortedList[sortedList.count])
            } else {
                sortedList.insert(unsortedList[sortedList.count], at: mid + 1)
            }
            low = 0
            high = sortedList.count - 1
        } else if id == sortedList[mid].id {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
}
