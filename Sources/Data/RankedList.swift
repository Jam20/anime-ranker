//
//  File.swift
//  
//
//  Created by James Brouckman on 8/18/23.
//

import Foundation

struct RankedList: Codable {
    private var unsortedList: [Int]
    private var sortedList: [Int]
    private var low, high : Int
    private var mid: Int { (low + high) / 2 }
    var leftToSort: Int { unsortedList.count }
    
    init(_ unsortedList: [Int]) {
        self.unsortedList = unsortedList
        self.sortedList = [self.unsortedList.removeFirst()]
        self.low = 0
        self.high = sortedList.count - 1
    }
    
    func next() -> (Int, Int)? {
        guard let unsortedVal = unsortedList.first else { return nil }
        return (unsortedVal, sortedList[mid])
    }
    
    mutating func resolve(_ value: Int) {
        print("low: \(low) mid: \(mid) high: \(high)")
        let isMidValue = value == sortedList[mid]
        if low >= high {
            let unsortedValue = unsortedList.removeFirst()
            let index = isMidValue ? mid : mid + 1
            sortedList.insert(unsortedValue, at: index)
            low = 0
            high = sortedList.count - 1
        } else if isMidValue {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
    
    func getList() -> [Int] {
        self.sortedList.reversed()
    }
}
